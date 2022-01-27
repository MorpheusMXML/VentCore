import 'package:get/get.dart';
import 'package:uke_mlab/models/data_models/model_absolute.dart';
import 'package:uke_mlab/models/data_models/model_manager.dart';
import 'package:uke_mlab/models/screen_element_models/general_alarms.dart';
import 'package:uke_mlab/models/screen_element_models/smart_adjustment_model.dart';

import 'package:uke_mlab/models/system_state.dart';
import 'package:uke_mlab/providers/sound_controller.dart';

import 'package:uke_mlab/utilities/enums/alarm_status.dart';
import 'package:uke_mlab/utilities/enums/alarm_message.dart';
import 'package:uke_mlab/utilities/enums/non_graph_alarm.dart';
import 'package:uke_mlab/utilities/enums/screen_status.dart';
import 'package:uke_mlab/utilities/enums/sensor.dart';

/// ### This Class provides the alarm management and alarm triggering functionallity for visual and auditory.
///
/// This [AlarmController] follows the concept of reacting to pushed information by [DataModelAbsolute] or reacting while listening to specific [GeneralAlarms].
/// This react by the [AlarmController] is structured into evaluating and update in following areas:
/// 1. alarmstate with the help of [evaluateAlarmState] and this is followed by [updateAlarmState] if necessary.
/// 2. soundstate with the help of [evaluateSoundList] and this is followed by [updateSoundList].
/// 3. alarmsound with the help of [evaluateAlarmSound] and this is followed by triggering the [SoundController].
///
/// ### Class Variables
/// - [_systemState]  loads an instance this [SystemState] via [GetX]
///
/// - [_confirmMap] provides a [Map] to save [triggerConfirm] calls for given [sensorEnumAbsolute].
/// - [_soundList] provides a [List] and assits to identify the alarm with the highest [alarmStatus].
/// - [_alarmTypes] provides a [List] and assits to identify the specific [SoundIdentifier] in [evaluateAlarmSound].
/// - [_previousAlarmSound] saves the previous thrown alarm so this [evaluateAlarmSound] can refer to [_previousAlarmSound].
/// - [_modelManager] loads an instance of [ModelManager]
/// - [_systemState]  loads an instance this [SystemState] via [GetX]
///
/// {@category Providers}
class AlarmController {
  /// This provides a [Map] to save [triggerConfirm] calls for given [sensorEnumAbsolute].
  final Map<sensorEnumAbsolute, dynamic> _confirmMap =
      <sensorEnumAbsolute, dynamic>{};

  /// This provides a [List] and assits to identify the alarm with the highest [alarmStatus].
  final List<SoundListEntry> _soundList = <SoundListEntry>[];

  /// This provides a [List] and assits to identify the specific [SoundIdentifier] in [evaluateAlarmSound].
  final List<bool> _alarmTypes = [false, false];

  /// This saves the previous thrown alarm so this [evaluateAlarmSound] can refer to [_previousAlarmSound].
  SoundIdentifier? _previousAlarmSound;

  /// Loads an instance of [SoundController]
  final SoundController _soundController = Get.find<SoundController>();

  /// Loads an instance of [ModelManager] the purpose is to register the [AlarmController] in the [ModelManager].
  final ModelManager _modelManager;

  /// Loads an instance of [SystemState] and bind it to [GetX].
  final SystemState _systemState = Get.find<SystemState>();

  /// Register AlarmController in the instance of [_modelManager] and start listeners.
  AlarmController(this._modelManager) {
    _modelManager.registerAlarmController(this);
    initListeners();
  }

  /// initiate listeners for [AlarmController] handling
  void initListeners() {
    /// Listen [GeneralAlarms] and and trigger [_soundList] for every Alarm
    _systemState.generalAlarms.alarmList.listen((alarmList) {
      if (alarmList.isNotEmpty) {
        for (var i = 0; i < alarmList.length - 1; i++) {
          evaluateSoundList(alarmList[i].alarm, alarmList[i].priority);
        }
      }
    });

    /// reset alarm sound after changing screens
    _systemState.selectedToggleView.listen((selectedToggleView) {
      _previousAlarmSound = null;
    });
  }

  ///Checks if a new added value in this [DataModelAbsolute] cause an alarm.
  ///
  ///This function is build to be called in the [DataModelAbsolute].
  ///This [sensor] is checked against:
  ///- Boundary Violation
  ///- Warning (Value Deviation)
  ///
  /// If this [sensor] doesn´t match in this categories, it will set back to [alarmStatus.none].
  void evaluateAlarmState(sensorEnumAbsolute sensor) {
    dynamic value =
        Get.find<DataModelAbsolute>(tag: sensor.name).absoluteValue.value;
    dynamic upper =
        Get.find<DataModelAbsolute>(tag: sensor.name).upperAlarmBound.value;
    dynamic lower =
        Get.find<DataModelAbsolute>(tag: sensor.name).lowerAlarmBound.value;
    RxList historicValues =
        Get.find<DataModelAbsolute>(tag: sensor.name).historicValues;

    ///Possible deviation arounde the upper and lower boundaries.
    dynamic allowedValueDeviation = (upper - lower) / 2;

    ///Initialize actual value difference. default is the value.
    dynamic valueDeviation = value;

    /// Update valueDifference with historicValues.
    if (historicValues.isNotEmpty) {
      valueDeviation = (historicValues[0] - value).abs();
    }

    ///Boundary Violation
    ///
    ///Evaluate upper alarm boundary. Here we trigger [alarmMessage.upperBoundaryViolated].
    if (value > upper) {
      ///Checks how serious the upper boundary is exceeded.
      if (sensor.boundaryDeviation != null &&
          value < upper * (1 + sensor.boundaryDeviation)) {
        updateAlarmState(
          sensor,
          alarmMessage.upperBoundaryViolated,
          alarmStatus.middle,
        );
        return;
      } else {
        updateAlarmState(
          sensor,
          alarmMessage.upperBoundaryViolated,
          alarmStatus.high,
        );
        return;
      }
    }

    ///Evaluate lower alarm boundary.
    else if (value < lower) {
      ///Checks how serious the lower boundary is exceeded. Here we trigger [alarmMessage.lowerBoundaryViolated].
      if (sensor.boundaryDeviation != null &&
          value > lower * (1 - sensor.boundaryDeviation)) {
        updateAlarmState(
          sensor,
          alarmMessage.lowerBoundaryViolated,
          alarmStatus.middle,
        );
        return;
      } else {
        updateAlarmState(
          sensor,
          alarmMessage.lowerBoundaryViolated,
          alarmStatus.high,
        );
        return;
      }
    }

    /// Warning
    ///
    ///Trigger deviation alarm if previous values deviate more than [sensor.boundaryDeviation] is allowing.
    else if (valueDeviation > allowedValueDeviation) {
      updateAlarmState(
        sensor,
        alarmMessage.deviation,
        alarmStatus.warning,
      );
      return;
    }

    ///Adjust Priority if no Alarm is detected at all.
    else {
      updateAlarmState(
        sensor,
        alarmMessage.none,
        alarmStatus.none,
      );
    }
  }

  /// Update the alarm state in [_systemState] and triggers an update in [_soundList].
  ///
  /// It prevents an update in the case of:
  /// - [sensor] is in [alarmStatus.confirmed]
  /// - [alarmStatus] or [alarmMessage] did not change.
  /// Otherwise [_systemState] alarm state for given [sensor] will be updated.
  /// In every case [evaluateSoundList] is called to ensure a right sound production.
  void updateAlarmState(
    sensorEnumAbsolute sensor,
    alarmMessage message,
    alarmStatus status,
  ) {
    ///Prevent update because [alarmStatus.confirmed] is confirmed or [endConfirmStatus]
    if (_systemState.getAlarmStateStatus(sensor) == alarmStatus.confirmed) {
      if (isSensorWithinConfirmDuration(sensor) &&
          _systemState.getAlarmStateMessage(sensor) == message.message &&
          _systemState.getAlarmStatePriority(sensor) >= status.priority) {
        _systemState.setAlarmState(
          sensor,
          status.priority,
          null,
          null,
          status.color,
        );

        /// Trigger Sound State for Confirmed Alerts
        evaluateSoundList(sensor, alarmStatus.confirmed.priority);
        return;
      } else {
        endConfirmStatus(sensor, status);
      }
    }

    ///Prevent update because same [alarmStatus] and [alarmMessage] are same
    if (_systemState.getAlarmStatePriority(sensor) == status.priority &&
        _systemState.getAlarmStateMessage(sensor) == message.message) {
      ///Trigger soundstate for not changed Alerts.
      evaluateSoundList(sensor, status.priority);
      return;
    }

    ///Update AlarmState if change is detected
    if (_systemState.getAlarmStatePriority(sensor) != status.priority ||
        _systemState.getAlarmStateMessage(sensor) != message.message) {
      /// Check if middle alarm is repeating and needs to change boundaries
      if (_systemState.getAlarmStatePriority(sensor) ==
              alarmStatus.none.priority &&
          status.priority == alarmStatus.middle.priority) {
        evaluateBoundaryAdjustment(sensor, message);
      }
      _systemState.setAlarmState(
        sensor,
        status.priority,
        message.message,
        status,
        status.color,
      );
    }
    evaluateSoundList(sensor, status.priority);
  }

  /// Set [alarmStatus.confirmed] for given [sensor] and set a timestamp in [_confirmMap]
  ///
  /// Ensured the alarmState is evaluated correctly afterwards.
  void triggerConfirm(sensorEnumAbsolute sensor) {
    _systemState.setAlarmState(sensor, null, null, alarmStatus.confirmed, null);
    _confirmMap[sensor] = DateTime.now();

    evaluateAlarmState(sensor);
  }

  /// Evaluates if given [sensor] is within a given [sensor.confirmDuration].
  ///
  /// Also returns fales if no sensor is found in the [_confirmMap].
  bool isSensorWithinConfirmDuration(
    sensorEnumAbsolute sensor,
  ) {
    if (_confirmMap[sensor] != null) {
      ///This time [diff] between the call of confirm to now for individual [sensor].
      Duration diff = DateTime.now().difference(_confirmMap[sensor]);

      ///Is confirmDuration valid.
      if (diff.inSeconds <= sensor.confirmDuration) {
        return true;
      }
    }
    return false;
  }

  /// Reset [alarmStatus.confirmed] for given [sensor].
  ///
  /// Note this [alarmMessage] is null because the previous [alarmMessage] needs to be safed in the alarm state.
  void endConfirmStatus(sensor, alarmStatus status) {
    _systemState.setAlarmState(
      sensor,
      status.priority,
      null,
      status,
      status.color,
    );

    ///reset alarm sound to acknowledge new alarmSituation
    _previousAlarmSound = null;
  }

  /// Evaluate to show a button for automatic boundary adjustment for given [sensor].
  ///
  /// This happens everytime when triggering [alarmStatus.middle] for given [sensor].
  /// The tolerance of this event is defined in the [SmartAdjustmentMap].
  void evaluateBoundaryAdjustment(
      sensorEnumAbsolute sensor, alarmMessage message) {
    ///checks which Boundary was violated
    if (message == alarmMessage.lowerBoundaryViolated) {
      _systemState.smartAdjustmentMap.updateLowerCounter(sensor);
      return;
    } else if (message == alarmMessage.upperBoundaryViolated) {
      _systemState.smartAdjustmentMap.updateUpperCounter(sensor);
      return;
    } else {
      throw Exception(
          "Message field was $message instead of alarmMessage.lowerBoundaryViolated or alarmMessage.upperBoundaryViolated");
    }
  }

  /// Evaluate in which way [updateSoundList] should be triggered.
  ///
  /// Stops the alarm sound via [_soundController] if we are in the [screenStatusEnum.defibrillationScreen].
  void evaluateSoundList(dynamic sensor, int priority) {
    if (_systemState.screenStatus == screenStatusEnum.defibrillationScreen) {
      _soundController.stopAlarmTimer();
      updateSoundList(sensor, alarmStatus.none.priority);
    } else {
      updateSoundList(sensor, priority);
    }
  }

  /// Sort [_soundList] which assits to identify the alarm with the highest [alarmStatus]
  ///
  /// This [_soundList] is cleared for non active alarms and afterwards it is sorted.
  /// The first entry define the [priority] for the [evaluateAlarmSound].
  /// Note the breakout case if the given [priority] is not higher than the first entry in [_soundList] then we dont need to [evaluateAlarmSound].
  void updateSoundList(dynamic sensor, int priority) {
    /// compare list with current system state
    _soundList.removeWhere((element) {
      /// checks whether element is in systemState.graphList.activeGraphAbsolutes or systemState.absAlarmFieldModel.activeList if so => remove from soundList.
      if (element.type is sensorEnumAbsolute) {
        return !_systemState.graphList.activeGraphAbsolutes
                .contains(element.type as sensorEnumAbsolute) &&
            !_systemState.absAlarmFieldModel.activeList
                .contains(element.type as sensorEnumAbsolute);

        /// checks whether element is in generalAlarms, if so returns false => not remove from soundList.
      } else if (element.type is nonGraphAlarmEnum) {
        for (var item in _systemState.generalAlarms.alarmList) {
          if (item.alarm == element.type as nonGraphAlarmEnum) {
            return false;
          }
        }
        return true;
      } else {
        throw Exception(
            "soundList does contain an element which has neither sensorEnumAbsolute nor nonGraphAlarmEnum as type");
      }
    });

    _soundList.removeWhere((item) => item.type == sensor);

    /// is given sensor in any active list then add it to the soundList
    if ((sensor is sensorEnumAbsolute &&
            (_systemState.absAlarmFieldModel.activeList.contains(sensor) ||
                _systemState.graphList.activeGraphAbsolutes
                    .contains(sensor))) ||
        (sensor is nonGraphAlarmEnum &&
            _systemState.generalAlarms.checkForAlarm(sensor))) {
      _soundList.add(SoundListEntry(type: sensor, priority: priority));
    }

    /// sort the soundlist so that [0] is the highest prio
    _soundList.sort((a, b) => b.priority.compareTo(a.priority));

    _soundList.removeWhere((item) => item.priority < _soundList[0].priority);
    if (_soundList.isEmpty) {
      _soundController.stopAudioPlayer(_soundController.alarmPlayer);
      _soundController.stopAlarmTimer();
      return;
    }

    /// Don't play a sound when prio of new alarm is below prio of max alarm.
    if (_soundList[0].priority > priority) {
      return;
    }
    evaluateAlarmSound(_soundList[0].priority);
  }

  /// Evaluate the [alarmSound] and [timerDuration] with matching [priority] for the [_soundController].
  ///
  /// [_alarmTypes] are used to define the [sensorEnumAbsolute.alarmType] for example a monitoring alert.
  void evaluateAlarmSound(int priority) {
    /// initalzied with 0 for no looping alarm sounds
    int timerDuration = 0;

    /// nullable alarmSound so that no matched alarmSound is possible for breakout case
    SoundIdentifier? alarmSound;

    /// warning sound or alarmType check
    if (priority == alarmStatus.warning.priority) {
      /// play warning sound
      alarmSound = SoundIdentifier.notification;
      timerDuration = 0;
    }

    /// for each entry fill sensor alarmtype if vent or monitor.
    else {
      for (var entry in _soundList) {
        if (entry.type is sensorEnumAbsolute) {
          switch ((entry.type as sensorEnumAbsolute).alarmType) {
            case 1: // is monitor alarm
              _alarmTypes[0] = true;
              break;
            case 2: // is ventilator alarm
              _alarmTypes[1] = true;
              break;
            default:
              throw Exception("sensorEnumAbsolute has wrong defined alarmType");
          }
        }
      }

      /// analyze the alarm types
      if (_alarmTypes[0] && _alarmTypes[1]) {
        /// play monitor + vent sounds.
        if (priority == alarmStatus.high.priority) {
          alarmSound = SoundIdentifier.monitoringHighAlert;
          timerDuration = 2;
        } else if (priority == alarmStatus.middle.priority) {
          alarmSound = SoundIdentifier.monitoringMediumAlert;
          timerDuration = 3;
        }
      } else if (_alarmTypes[1] && !_alarmTypes[0]) {
        /// play vent alarm.
        if (priority == alarmStatus.high.priority) {
          alarmSound = SoundIdentifier.ventilationHighAlert;
          timerDuration = 2;
        } else if (priority == alarmStatus.middle.priority) {
          alarmSound = SoundIdentifier.ventilationMediumAlert;
          timerDuration = 3;
        }
      } else {
        /// play monitor alarm.
        if (priority == alarmStatus.high.priority) {
          alarmSound = SoundIdentifier.monitoringHighAlert;
          timerDuration = 2;
        } else if (priority == alarmStatus.middle.priority) {
          alarmSound = SoundIdentifier.monitoringMediumAlert;
          timerDuration = 3;
        }
      }
    }

    /// Breakout and don't reset timer if same [alarmSound] should be triggered as [_previousAlamSound].
    if (alarmSound == _previousAlarmSound) {
      _alarmTypes[0] = false;
      _alarmTypes[1] = false;
      return;
    }

    /// Breakout and stop the [alarmTimer] if [priority] is smaller than [alarmStatus.confirmed] or no [alarmSound] is choosen.
    else if (alarmSound == null || priority <= alarmStatus.confirmed.priority) {
      _soundController.stopAudioPlayer(_soundController.alarmPlayer);
      _soundController.stopAlarmTimer();
      _alarmTypes[0] = false;
      _alarmTypes[1] = false;
      _previousAlarmSound = null;
      return;
    }

    ///Register new [alarmTimer] with [alarmSound], [alarmDuration] and [alarmVolume].
    else {
      _soundController.stopAlarmTimer();

      _soundController.playAlarmSound(alarmSound, timerDuration);
    }

    ///Reset alarm types and set previous alarm sound for next evaluation.
    _alarmTypes[0] = false;
    _alarmTypes[1] = false;
    _previousAlarmSound = alarmSound;
  }
}

/// This is an entry for [_soundList] and is used to store so called sensor[type] and their [priority] for the sound evaluation.
///
/// this is an helper class to create a useful [List]
class SoundListEntry {
  /// type for example a [sensorEnumAbsolute]
  final dynamic type;

  /// priority of the alarm, should be between 0 and 100
  final int priority;

  SoundListEntry({
    required this.type,
    required this.priority,
  });
}
