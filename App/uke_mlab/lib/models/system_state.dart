import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/models/data_models/model_absolute.dart';

import 'package:uke_mlab/models/screen_element_models/general_alarms.dart';
import 'package:uke_mlab/models/screen_element_models/absolute_alarm_field_model.dart';
import 'package:uke_mlab/models/screen_element_models/graph_list.dart';
import 'package:uke_mlab/models/screen_element_models/ippv_model.dart';
import 'package:uke_mlab/models/screen_element_models/smart_adjustment_model.dart';
import 'package:uke_mlab/models/screen_element_models/theme_model.dart';
import 'package:uke_mlab/utilities/enums/alarm_message.dart';

import 'package:uke_mlab/utilities/enums/alarm_status.dart';
import 'package:uke_mlab/utilities/enums/sensor.dart';
import 'package:uke_mlab/utilities/enums/screen_status.dart';
import 'package:uke_mlab/utilities/enums/patient_type.dart';

import 'package:uke_mlab/utilities/app_theme.dart';

import 'package:uke_mlab/scenarios/abstract_scenario.dart';

import 'package:uke_mlab/screens/main_screen.dart';

/// Superclass holding references to various models for screen elements as well as holding the top level information of current status of the system.
/// {@category SystemState}
class SystemState extends GetxController {
  /// Contains global information whether an [AbstractScenario] is active.
  bool scenarioStarted = false;

  /// Contains information which screen is currently active using an element of [screenStatusEnum].
  screenStatusEnum screenStatus = screenStatusEnum.patientSettingScreen;

  /// Contains information which patient Type is currently active using an element of [patientTypeEnum].
  patientTypeEnum patientType = patientTypeEnum.none;

  /// Contains information which of the three monitoring, ventilation, defibrillation is currently active in [MainScreen] as a list of true or false values corresponding to the order given above.
  RxList<bool> selectedToggleView = [true, false, false].obs;

  /// Contains global information about the status of the [sensorEnumAbsolute].
  ///
  /// Includes is in which [alarmStatus],
  /// is of what priority, corresponds to which color and which alarm message will be printed on request
  /// this is done via the RxMap with the following keys:
  /// "priority" for priority
  /// "message" for alarm message
  /// "enum" for current [alarmStatus]
  /// "color" for color
  final RxMap<sensorEnumAbsolute, Map<String, dynamic>> alarmState = <sensorEnumAbsolute, Map<String, dynamic>>{}.obs;

  /// A reference to the current [GeneralAlarms] in use.
  final GeneralAlarms generalAlarms = GeneralAlarms();

  /// A reference to the current [GraphList] in use.
  final GraphList graphList = GraphList();

  /// A reference to the current [AbsAlarmFieldModel] in use.
  final AbsAlarmFieldModel absAlarmFieldModel = AbsAlarmFieldModel();

  /// A reference to the current [IppvModel] in use.
  final IppvModel ippvModel = IppvModel();

  /// A reference to the current [ThemeModel] in use.
  final ThemeModel themeModel = ThemeModel();

  /// A reference to the current [SmartAdjustmentMap] in use. Used for smartAdjustment.
  final SmartAdjustmentMap smartAdjustmentMap = SmartAdjustmentMap();

  // SystemState initated with no violations at place and screenStatus as topLevelScreen
  SystemState() {
    for (var sensor in sensorEnumAbsolute.values) {
      alarmState[sensor] = {
        'priority': alarmStatus.none.priority,
        'message': alarmMessage.none.message,
        'status': alarmStatus.none,
        'color': AppTheme.alarmNoneColor,
      };
    }
  }

  /// Get [alarmState].[alarmStatus.priority] for given [sensor].
  int getAlarmStatePriority(sensorEnumAbsolute sensor) {
    return alarmState[sensor]!['priority'];
  }

  /// Get [alarmState].[alarmMessage] for given [sensor].
  String getAlarmStateMessage(sensorEnumAbsolute sensor) {
    return alarmState[sensor]!['message'];
  }

  /// Get [alarmState].[alarmStatus.status]  for given [sensor].
  alarmStatus getAlarmStateStatus(sensorEnumAbsolute sensor) {
    return alarmState[sensor]!['status'];
  }

  /// Get [alarmState].[alarmStatus.color] for given [sensor].
  Color getAlarmStateColor(sensorEnumAbsolute sensor) {
    return alarmState[sensor]!['color'];
  }

  /// overwrites [selectedToggleView]s value with [newToggleView] for usage on switch between
  /// monitoring, ventilation and defibrillation representation in [MainScreen]
  void setSelectedToggleView(List<bool> newToggleView) {
    for (var sensor in sensorEnumAbsolute.values) {
      Get.find<DataModelAbsolute>(tag: sensor.name).hideOverlay();
    }
    selectedToggleView.value = newToggleView;
    update();
  }

  ///Set [alarmState] for given [sensor].
  void setAlarmState(sensorEnumAbsolute sensor, int? priority, String? message, alarmStatus? status, Color? color) {
    alarmState[sensor] = {
      'priority': priority ?? alarmState[sensor]!['priority'],
      'message': message ?? getAlarmStateMessage(sensor),
      'status': status ?? alarmState[sensor]!['status'],
      'color': color ?? alarmState[sensor]!['color'],
    };
    graphList.evaluateActiveGraphAbsolutes();
    absAlarmFieldModel.evaluateActiveList();
  }

  /// resets the [SystemState]s elements (currently only [ippvModel])
  void resetSystemState() {
    ippvModel.resetIPPV();
  }
}
