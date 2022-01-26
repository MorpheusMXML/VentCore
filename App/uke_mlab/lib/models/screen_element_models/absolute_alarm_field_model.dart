import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/models/system_state.dart';
import 'package:uke_mlab/models/data_models/model_absolute.dart';

import 'package:uke_mlab/utilities/enums/sensor.dart';
import 'package:uke_mlab/utilities/enums/alarm_status.dart';

import 'package:uke_mlab/widgets/value_box/value_box_tile.dart';
import 'package:uke_mlab/widgets/value_box/value_box_tile_nibd.dart';

import 'package:uke_mlab/widgets/value_box/alarm_confirmation/alarm_confirmation_button_single_list.dart';

/// Provides an overview which [ValueBoxTile] and [ValueBoxTileNIBD]s are currently represented on screen and which of them has a current active [alarmStatus].
/// {@category Models}
/// {@subCategory Screen Element Models}
class AbsAlarmFieldModel extends GetxController {
  /// The [OverlayEntry] for [AlarmButtonAbsoluteList].
  OverlayEntry? entry;

  /// Contains information whether [AlarmButtonAbsoluteList] is currently active or not.
  RxBool listExpanded = false.obs;

  /// A set over all the [sensorEnumAbsolute]s representing the [ValueBoxTile] and [ValueBoxTileNIBD]s.
  ///
  /// Currently active in the monitor Screen for access to the corresponding [DataModelAbsolute].
  final Set<sensorEnumAbsolute> monitorSet = {
    sensorEnumAbsolute.diaAbsolute,
    sensorEnumAbsolute.sysAbsolute,
    sensorEnumAbsolute.tempAbsolute,
    sensorEnumAbsolute.pulse
  };

  /// A set over all the [sensorEnumAbsolute]s representing the [ValueBoxTile] and [ValueBoxTileNIBD]s.
  ///
  /// Currently active in the ventilation Screen for access to the corresponding [DataModelAbsolute].
  final Set<sensorEnumAbsolute> ventilationSet = {
    sensorEnumAbsolute.breathfrequency,
    sensorEnumAbsolute.mve,
    sensorEnumAbsolute.hfAbsolute
  };

  /// A set over all the [sensorEnumAbsolute]s representing the [ValueBoxTile] and [ValueBoxTileNIBD]s.
  ///
  /// Currently active in the defibrillation Screen for access to the corresponding [DataModelAbsolute]
  final Set<sensorEnumAbsolute> defiSet = {}; // will be unused at the moment, but here for completion

  /// Represents a subset of the current Set as list containing the current active [sensorEnumAbsolute]s.
  final RxList<sensorEnumAbsolute> activeList = <sensorEnumAbsolute>[].obs;

  /// Updates the current [activeList] so that it only contains the [sensorEnumAbsolute]s of not confirmed and active alarms.
  ///
  /// If [activeList] is empty [AlarmButtonAbsoluteList] will be closed.
  void evaluateActiveList() {
    SystemState systemState = Get.find<SystemState>();

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
      activeList.removeWhere((sensorKey) =>
          systemState.alarmState[sensorKey]!["status"] == alarmStatus.none ||
          systemState.alarmState[sensorKey]!["status"] == alarmStatus.confirmed);
    }

    // if there are not any Elements in list left and list is expanded => overlay
    if ((activeList.isEmpty && listExpanded.value)) {
      closeOverlay();
    }
  }

  /// closes [AlarmButtonAbsoluteList], sets [entry] to null and [listExpanded] to false
  void closeOverlay() {
    SystemState systemState = Get.find<SystemState>();
    systemState.absAlarmFieldModel.entry?.remove();
    systemState.absAlarmFieldModel.entry = null;
    systemState.absAlarmFieldModel.listExpanded.value = false;
  }
}
