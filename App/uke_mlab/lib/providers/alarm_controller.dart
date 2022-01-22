import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/models/data_models/model_manager.dart';
import 'package:uke_mlab/models/system_state.dart';
import 'package:uke_mlab/providers/sound_controller.dart';

import 'package:uke_mlab/utilities/enums/alarm_status.dart';
import 'package:uke_mlab/utilities/enums/alarm_message.dart';
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
  final Map soundMap = <int, dynamic>{};
  final ModelManager _modelManager;
  final SoundController _soundController = Get.find<SoundController>();
  final SystemState _systemState = Get.find<SystemState>();
  AlarmController(this._modelManager) {
    _modelManager.registerAlarmController(this);
    listen();
  }
  void listen() {
    _systemState.generalAlarms.alarmList.listen((alarmList) {
      print("listenGeneralAlarmList");
      for (var i = 0; i < alarmList.length - 1; i++) {
        _soundController.triggerSoundState(
            alarmList[i].alarm, alarmList[i].priority);
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
  void evaluateAlarmState(
      value, upper, lower, RxList historicValues, sensorEnumAbsolute sensor) {
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
    int priority = status.priority;
    if (_systemState.absAlarmFieldModel.activeList.contains(sensor) ||
        _systemState.graphList.activeGraphAbsolutes.contains(sensor)) {
      _soundController.triggerSoundState(sensor, status.priority);
    }

    ///Prevent update because [alarmStatus.confirmed] is confirmed or [endConfirmStatus]
    if (isConfirmInConfirmDuration(sensor) &&
        _systemState.getAlarmStateMessage(sensor) == message.message &&
        _systemState.getAlarmStatePriority(sensor) >= status.priority) {
      _systemState.setAlarmState(
        sensor,
        status.priority,
        null,
        null,
        status.color,
      );
      return;
    } else {
      endConfirmStatus(sensor, status);
    }

    ///Prevent update because same [alarmStatus] and [alarmMessage] are same
    if (_systemState.getAlarmStatePriority(sensor) == status.priority &&
        _systemState.getAlarmStateMessage(sensor) == message.message) {
      return;
    }

    ///Update AlarmState if change is detected
    if (_systemState.getAlarmStatePriority(sensor) != priority ||
        _systemState.getAlarmStateMessage(sensor) != message.message) {
      _systemState.setAlarmState(
        sensor,
        priority,
        message.message,
        status,
        status.color,
      );
    }

    ///TODO: implement  triggerSoundState Method for sounds
  }
  // void triggerAlarmState(sensorEnumAbsolute sensor,
  //     alarmMessage alarmMessageEnum, alarmStatus alarmPrioEnum) {
  //   int newPriority = alarmPrioEnum.priority;
  //   String newMessage = alarmMessageEnum.message;

  //   /// This alarm is confirmed
  //   /// This alarm has a lower or same priority
  //   /// This alarm has same Message
  //   if (_systemState.alarmState[sensor]!['enum'] == alarmStatus.confirmed &&
  //       newPriority <= _systemState.alarmState[sensor]!['priority'] &&
  //       _systemState.alarmState[sensor]!['message'] == newMessage) {
  //     ///This time difference between the call of confirm to now
  //     Duration diff = DateTime.now().difference(confirmMap[sensor]);
  //     if (diff.inSeconds >= sensor.confirmDuration) {
  //       ///reset this confirm to the previous alarm
  //       for (alarmStatus status in alarmStatus.values) {
  //         if (_systemState.alarmState[sensor]!['priority'] ==
  //             status.priority) {
  //           _systemState.alarmState[sensor]!['enum'] = status;
  //           _systemState.graphList.evaluateActiveGraphAbsolutes();
  //           _systemState.absAlarmFieldModel.updateActiveList();
  //         }
  //       }
  //     }
  //   }

  //   ///This alarm is not a previous thrown alarm and not confirmed
  //   else if (_systemState.alarmState[sensor]!['priority'] != newPriority ||
  //       _systemState.alarmState[sensor]!['message'] != newMessage) {
  //     ///Update [SystemState]
  //     _systemState.alarmState[sensor]!['priority'] = newPriority;
  //     _systemState.alarmState[sensor]!['message'] = newMessage;
  //     _systemState.alarmState[sensor]!['enum'] = alarmPrioEnum;
  //     _systemState.alarmState[sensor]!['color'] = alarmPrioEnum.color;
  //   }
  // }

  void triggerSoundState(alarmStatus alarmPrioEnum, sensorEnumAbsolute sensor) {
    ///Avoid null exception.
    ///
    ///Alarm Priorität prüfen
    ///Diese Map dann gegen Sensor Priorität prüfen
    ///Alarm auspielen für den höchsten Alarm

    SoundIdentifier? sound = alarmPrioEnum.sound;
    if (sound != null) {}
  }

  // void evaluateSoundState(name, prio, montirOrVent) {
  //   List soundList = List.from(_systemState.alarmState.values.toList());
  //   soundList.addAll(_systemState.generalAlarms.alarmList);
  //   print(soundList);
  //   var sortedKey = _systemState.alarmState.keys.toList.sort();
  //   // Map {}
  // }

  //TODO: change upper and lower boundary if patient value is around that value everytime
  void evaluateBoundaryAdjustment() {}

  void triggerConfirm(sensorEnumAbsolute sensor) {
    _systemState.setAlarmState(sensor, null, null, alarmStatus.confirmed, null);
    _systemState.graphList.evaluateActiveGraphAbsolutes();
    _systemState.absAlarmFieldModel.updateActiveList();
    confirmMap[sensor] = DateTime.now();

    ///TODO: trigger evaluateAlarmState();
  }

  bool isConfirmInConfirmDuration(
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
    for (alarmStatus status in alarmStatus.values) {
      if (_systemState.getAlarmStatePriority(sensor) == status.priority) {
        _systemState.setAlarmState(
          sensor,
          status.priority,
          null,
          status,
          status.color,
        );
      }
    }
  }
}
