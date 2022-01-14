import 'package:get/get.dart';
import 'package:uke_mlab/models/model_manager.dart';
import 'package:uke_mlab/models/system_state.dart';

import 'package:uke_mlab/utilities/enums/alarm_priority.dart';
import 'package:uke_mlab/utilities/enums/alarm_message.dart';
import 'package:uke_mlab/utilities/enums/sensor.dart';

///
///
class AlarmController {
  ///Manages and throws Alarms with an implemented Alarm Logic.
  final Map<sensorEnumAbsolute, dynamic> alarmMap =
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
  void evaluateAlarm(value, upper, lower, sensorEnumAbsolute sensorKey) {
    dynamic boundaryDeviation = sensorKey.boundaryDeviation;
    //possible deviation arounde the upper and lower boundaries
    dynamic valueDeviation = (upper - lower) / 2;
    dynamic valueDifference = value - value;

    //Boundary Violation

    //value exceed upper alarm boundary
    if (value > upper) {
      //checks how serious the boundary is exceeded
      if (boundaryDeviation != null &&
          value < upper * (1 + boundaryDeviation)) {
        triggerAlarm(sensorKey, alarmMessage.upperBoundaryViolated,
            alarmPriority.middle);
        return;
      } else {
        triggerAlarm(
            sensorKey, alarmMessage.upperBoundaryViolated, alarmPriority.high);
        return;
      }
    }
    //value exceed lower alarm boundary
    else if (value < lower) {
      //checks how serious the boundary is exceeded
      if (boundaryDeviation != null &&
          value > lower * (1 - boundaryDeviation)) {
        triggerAlarm(sensorKey, alarmMessage.lowerBoundaryViolated,
            alarmPriority.middle);
        return;
      } else {
        triggerAlarm(
            sensorKey, alarmMessage.lowerBoundaryViolated, alarmPriority.high);
        return;
      }
    }
    // Warning

    //is previous value Difference in allowed Deviation
    if (valueDifference > valueDeviation) {
      triggerAlarm(sensorKey, alarmMessage.deviation, alarmPriority.warning);
      return;
    }
  }

  void triggerAlarm(
      sensorKey, alarmMessage alarmMessageEnum, alarmPriority alarmPrioEnum) {
    int priority = alarmPrioEnum.priority;
    String message = alarmMessageEnum.message;

    // This alarm is confirmed
    // This alarm only changes if message or higher priority alarm is noticed
    if (_systemState.alarmState[sensorKey]!["alarmPriorityEnum"] ==
            alarmPriority.confirmed &&
        _systemState.alarmState[sensorKey]!["priority"] >= priority &&
        _systemState.alarmState[sensorKey]!["message"] == message) {
      //TODO: Confirmed State
    } else {
      if (_systemState.alarmState[sensorKey]!["priority"] != priority ||
          _systemState.alarmState[sensorKey]!["message"] != message) {
        ///Update [SystemState]
        _systemState.alarmState[sensorKey]!["priority"] = priority;
        _systemState.alarmState[sensorKey]!["message"] = message;
        _systemState.alarmState[sensorKey]!["alarmPriorityEnum"] =
            alarmPrioEnum;
        //Remember the thrown Alarm
        alarmMap[sensorKey] = DateTime.now();
        print(_systemState.alarmState[sensorKey]);
        print(alarmMap.length);
      }
    }
  }
}
