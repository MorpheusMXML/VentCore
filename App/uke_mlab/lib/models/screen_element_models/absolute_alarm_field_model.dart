import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/models/system_state.dart';
import 'package:uke_mlab/providers/alarm_controller.dart';
import 'package:uke_mlab/utilities/enums/sensor.dart';
import 'package:uke_mlab/utilities/enums/alarm_status.dart';

class AbsAlarmFieldModel extends GetxController {
  OverlayEntry? entry;
  RxBool listExpanded = false.obs;

  Set<sensorEnumAbsolute> monitorSet = {
    sensorEnumAbsolute.diaAbsolute,
    sensorEnumAbsolute.sysAbsolute,
    sensorEnumAbsolute.tempAbsolute,
    sensorEnumAbsolute.pulse
  };
  Set<sensorEnumAbsolute> ventilationSet = {
    sensorEnumAbsolute.breathfrequency,
    sensorEnumAbsolute.mve,
    sensorEnumAbsolute.hfAbsolute
  };
  Set<sensorEnumAbsolute> defiSet =
      {}; // will be unused at the moment, but here for completion

  /// set of active, non confirmed alarms on
  final Set<sensorEnumAbsolute> _activeSet = <sensorEnumAbsolute>{};

  Set<sensorEnumAbsolute> getActiveSet() {
    SystemState systemState = Get.find<SystemState>();
    AlarmController alarmController = Get.find<AlarmController>();

    _activeSet.clear();
    if (systemState.selectedToggleView[0]) {
      _activeSet.addAll(monitorSet);
    } else if (systemState.selectedToggleView[1]) {
      _activeSet.addAll(ventilationSet);
    } else if (systemState.selectedToggleView[2]) {
      _activeSet.addAll(defiSet);
    } else {
      throw Exception(
          "No Toggle view active while trying to form the set of active absolute value tiles on the current screen");
    }

    return _activeSet;
  }
}
