import 'package:get/get.dart';
import 'package:uke_mlab/models/data_models/model_manager.dart';
import 'package:uke_mlab/models/system_state.dart';

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
  late ModelManager _modelManager;
  final SystemState _systemState = Get.find<SystemState>();
  AlarmController(ModelManager modelManager) {
    _modelManager = modelManager;
    _modelManager.registerAlarmController(this);
  }

  ///Checks if a new added value in this [DataModel] should throw an alarm.
  ///
  ///This function is build to be called in the [DataModel].
  void evaluateAlarm(value, upper, lower, RxList historicValues,
      sensorEnumAbsolute sensorKey) {
    dynamic boundaryDeviation = sensorKey.boundaryDeviation;

    ///Possible deviation arounde the upper and lower boundaries
    dynamic valueDeviation = (upper - lower) / 2;
    dynamic valueDifference = value;
    if (historicValues.isNotEmpty) {
      valueDifference = (historicValues[0] - value).abs();
    }

    ///Boundary Violation

    ///Value exceed upper alarm boundary
    if (value > upper) {
      ///Checks how serious the boundary is exceeded
      if (boundaryDeviation != null &&
          value < upper * (1 + boundaryDeviation)) {
        triggerAlarm(
            sensorKey, alarmMessage.upperBoundaryViolated, alarmStatus.middle);
        return;
      } else {
        triggerAlarm(
            sensorKey, alarmMessage.upperBoundaryViolated, alarmStatus.high);
        return;
      }
    }

    ///Value exceed lower alarm boundary
    else if (value < lower) {
      ///Checks how serious the boundary is exceeded
      if (boundaryDeviation != null &&
          value > lower * (1 - boundaryDeviation)) {
        triggerAlarm(
            sensorKey, alarmMessage.lowerBoundaryViolated, alarmStatus.middle);
        return;
      } else {
        triggerAlarm(
            sensorKey, alarmMessage.lowerBoundaryViolated, alarmStatus.high);
        return;
      }
    }

    /// Warning

    ///is previous value Difference in allowed Deviation
    if (valueDifference > valueDeviation) {
      triggerAlarm(sensorKey, alarmMessage.deviation, alarmStatus.warning);
      return;
    }
  }

  void triggerAlarm(sensorEnumAbsolute sensorKey, alarmMessage alarmMessageEnum,
      alarmStatus alarmPrioEnum) {
    int newPriority = alarmPrioEnum.priority;
    String newMessage = alarmMessageEnum.message;

    /// This alarm is confirmed
    /// This alarm has a lower or same priority
    /// This alarm has same Message
    if (_systemState.alarmState[sensorKey]!["enum"] == alarmStatus.confirmed &&
        newPriority <= _systemState.alarmState[sensorKey]!["priority"] &&
        _systemState.alarmState[sensorKey]!["message"] == newMessage) {
      ///This time difference between the call of confirm to now
      Duration diff = DateTime.now().difference(confirmMap[sensorKey]);
      if (diff.inSeconds >= sensorKey.confirmDuration) {
        ///reset this confirm to the previous alarm
        for (alarmStatus status in alarmStatus.values) {
          if (_systemState.alarmState[sensorKey]!["priority"] ==
              status.priority) {
            _systemState.alarmState[sensorKey]!["enum"] = status;
            _systemState.evaluateActiveGraphAbsolutes();
            _systemState.absAlarmFieldModel.updateActiveList();
          }
        }
      }
    }

    ///This alarm is not a previous thrown alarm and not confirmed
    else if (_systemState.alarmState[sensorKey]!["priority"] != newPriority ||
        _systemState.alarmState[sensorKey]!["message"] != newMessage) {
      ///Update [SystemState]
      _systemState.alarmState[sensorKey]!["priority"] = newPriority;
      _systemState.alarmState[sensorKey]!["message"] = newMessage;
      _systemState.alarmState[sensorKey]!["enum"] = alarmPrioEnum;
      _systemState.alarmState[sensorKey]!["color"] = alarmPrioEnum.color;
    }
  }

  //TODO: change upper and lower boundary if patient value is around that value everytime
  void evaluateBoundaryAdjustment() {}

  void triggerConfirm(sensorEnumAbsolute sensorKey) {
    _systemState.alarmState[sensorKey]!["enum"] = alarmStatus.confirmed;
    _systemState.evaluateActiveGraphAbsolutes();
    _systemState.absAlarmFieldModel.updateActiveList();
    confirmMap[sensorKey] = DateTime.now();
  }
}
