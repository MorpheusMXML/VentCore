import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/models/system_state.dart';
import 'package:uke_mlab/providers/alarm_controller.dart';
import 'package:uke_mlab/utilities/enums/sensor.dart';
import 'package:uke_mlab/utilities/enums/alarm_status.dart';
import 'package:uke_mlab/utilities/enums/screen_status.dart';

class AbsAlarmFieldModel extends GetxController {
  OverlayEntry? entry;
  RxBool listExpanded = false.obs;

  final Set<sensorEnumAbsolute> monitorSet = {
    sensorEnumAbsolute.diaAbsolute,
    sensorEnumAbsolute.sysAbsolute,
    sensorEnumAbsolute.tempAbsolute,
    sensorEnumAbsolute.pulse
  };
  final Set<sensorEnumAbsolute> ventilationSet = {
    sensorEnumAbsolute.breathfrequency,
    sensorEnumAbsolute.mve,
    sensorEnumAbsolute.hfAbsolute
  };
  final Set<sensorEnumAbsolute> defiSet =
      {}; // will be unused at the moment, but here for completion

  final RxList<sensorEnumAbsolute> activeList = <sensorEnumAbsolute>[].obs;

  void updateActiveList() {
    SystemState systemState = Get.find<SystemState>();
    AlarmController alarmController = Get.find<AlarmController>();

    // loads absolute value tiles active in current screen into activeList
    if (systemState.selectedToggleView[0]) {
      activeList.value = monitorSet.toList();
    } else if (systemState.selectedToggleView[1]) {
      activeList.value = ventilationSet.toList();
    } else if (systemState.selectedToggleView[2]) {
      activeList.value = defiSet.toList();
    } else {
      throw Exception(
          "No Toggle view active while trying to form the set of active absolute value tiles on the current screen");
    }

    // if activeList isnt empty, remove sensors from list which are confirmed OR have no active alarm
    if (activeList.isNotEmpty) {
      for (var sensorKey in activeList.value) {
        if (systemState.alarmState[sensorKey]!["enum"] == alarmStatus.none ||
            systemState.alarmState[sensorKey]!["enum"] ==
                alarmStatus.confirmed) {
          activeList.value.remove(sensorKey);
        }
      }
    }

    // if there are not any Elements in list left and list is expanded => overlay
    if ((activeList.isEmpty && listExpanded.value)) {
      closeOverlay();
    }
  }

  void closeOverlay() {
    SystemState systemState = Get.find<SystemState>();
    systemState.absAlarmFieldModel.entry?.remove();
    systemState.absAlarmFieldModel.entry = null;
    systemState.absAlarmFieldModel.listExpanded.value = false;
  }
}
