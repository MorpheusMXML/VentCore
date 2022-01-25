import 'package:get/get.dart';
import 'package:uke_mlab/models/data_models/model_absolute.dart';
import 'package:uke_mlab/models/data_models/model_manager.dart';
import 'package:uke_mlab/models/system_state.dart';
import 'package:uke_mlab/providers/sound_controller.dart';

import 'package:uke_mlab/utilities/enums/alarm_status.dart';
import 'package:uke_mlab/utilities/enums/alarm_message.dart';
import 'package:uke_mlab/utilities/enums/screen_status.dart';
import 'package:uke_mlab/utilities/enums/sensor.dart';

/// This Class provides the SoundPlaying and Triggering Functionallity.
/// Alarms can be Triggered, stopped and the SpO2 / ECG Sound for the Heartfrequency can be started.
///
/// ### Class Variables
///
/// ### Methods
///
class AlarmController {
  ///Manages and throws Alarms with an implemented Alarm Logic.
  final Map<sensorEnumAbsolute, dynamic> confirmMap =
      <sensorEnumAbsolute, dynamic>{};
  final ModelManager _modelManager;
  final SoundController _soundController = Get.find<SoundController>();
  final SystemState _systemState = Get.find<SystemState>();

  AlarmController(this._modelManager) {
    _modelManager.registerAlarmController(this);
    listen();
  }

  /// soundTrigger for generalAlarms
  void listen() {
    _systemState.generalAlarms.alarmList.listen((alarmList) {
      //print("listenGeneralAlarmList");
      for (var i = 0; i < alarmList.length - 1; i++) {
        if (_systemState.screenStatus !=
            screenStatusEnum.defibrillationScreen) {
          _soundController.triggerSoundState(
              alarmList[i].alarm, alarmList[i].priority);
        }
      }
    });
  }

  ///Checks if a new added value in this [DataModelAbsolute] should throw an alarm.
  ///
  ///This function is build to be called in the [DataModelAbsolute].
  ///[value] is checked against:
  ///- Boundary Violation
  ///- Value Deviation
  ///- Zero Values
  ///
  ///[value] doesn´t [triggerAlarmState] in this categories, it will set back to [alarmStatus.none]
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
        triggerAlarmState(
          sensor,
          alarmMessage.upperBoundaryViolated,
          alarmStatus.middle,
        );
        return;
      } else {
        triggerAlarmState(
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
        triggerAlarmState(
          sensor,
          alarmMessage.lowerBoundaryViolated,
          alarmStatus.middle,
        );
        return;
      } else {
        triggerAlarmState(
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
      triggerAlarmState(
        sensor,
        alarmMessage.deviation,
        alarmStatus.warning,
      );
      return;
    }

    ///Adjust Priority if no Alarm is detected at all.
    else {
      triggerAlarmState(
        sensor,
        alarmMessage.none,
        alarmStatus.none,
      );
    }
  }

  void triggerAlarmState(
    sensorEnumAbsolute sensor,
    alarmMessage message,
    alarmStatus status,
  ) {
    ///Prevent update because [alarmStatus.confirmed] is confirmed or [endConfirmStatus]
    if (_systemState.getAlarmStateStatus(sensor) == alarmStatus.confirmed) {
      if (isSensorInConfirmDuration(sensor) &&
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
        triggerSoundController(sensor, alarmStatus.confirmed);
        return;
      } else {
        endConfirmStatus(sensor, status);
      }
    }

    ///Prevent update because same [alarmStatus] and [alarmMessage] are same
    if (_systemState.getAlarmStatePriority(sensor) == status.priority &&
        _systemState.getAlarmStateMessage(sensor) == message.message) {
      ///Trigger soundstate for not changed Alerts.
      triggerSoundController(sensor, status);
      return;
    }

    ///Update AlarmState if change is detected
    if (_systemState.getAlarmStatePriority(sensor) != status.priority ||
        _systemState.getAlarmStateMessage(sensor) != message.message) {
      // Check if middle alarm is repeating and needs to change boundaries
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
    triggerSoundController(sensor, status);
  }

  void triggerSoundController(sensorEnumAbsolute sensor, alarmStatus status) {
    ///Prevent sounds in defibrillationScreen:
    ///Stop [alarmTimer] and trigger [sensor] with no Priority
    if (_systemState.screenStatus == screenStatusEnum.defibrillationScreen) {
      if (_soundController.alarmTimer != null) {
        _soundController.alarmTimer?.cancel();
        _soundController.alarmTimer = null;
      }
      // _systemState.graphList.evaluateActiveGraphAbsolutes(); // done when alarm boundaries are set
      // _systemState.absAlarmFieldModel.evaluateActiveList();
      _soundController.triggerSoundState(sensor, alarmStatus.none.priority);
    } else {
      // _systemState.graphList.evaluateActiveGraphAbsolutes();
      // _systemState.absAlarmFieldModel.evaluateActiveList();
      _soundController.triggerSoundState(sensor, status.priority);
    }
  }

  //TODO: change upper and lower boundary if patient value is around that value everytime
  void evaluateBoundaryAdjustment(
      sensorEnumAbsolute sensor, alarmMessage message) {
    DateTime dateTime = DateTime.now();

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

  void triggerConfirm(sensorEnumAbsolute sensor) {
    _systemState.setAlarmState(sensor, null, null, alarmStatus.confirmed, null);
    // _systemState.graphList.evaluateActiveGraphAbsolutes();
    // _systemState.absAlarmFieldModel.evaluateActiveList();
    confirmMap[sensor] = DateTime.now();

    // TODO: reactivate
    evaluateAlarmState(sensor);
  }

  bool isSensorInConfirmDuration(
    sensorEnumAbsolute sensor,
  ) {
    if (confirmMap[sensor] != null) {
      ///This time [diff] between the call of confirm to now for individual [sensor].
      Duration diff = DateTime.now().difference(confirmMap[sensor]);

      ///Is confirmDuration valid.
      if (diff.inSeconds <= sensor.confirmDuration) {
        return true;
      }
    }
    return false;
  }

  void endConfirmStatus(sensor, alarmStatus status) {
    _systemState.setAlarmState(
      sensor,
      status.priority,
      null,
      status,
      status.color,
    );
  }
}
