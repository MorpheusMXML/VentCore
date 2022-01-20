import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/models/screen_element_models/general_alarms.dart';
import 'package:uke_mlab/models/screen_element_models/absolute_alarm_field_model.dart';
import 'package:uke_mlab/models/screen_element_models/graph_list.dart';
import 'package:uke_mlab/models/screen_element_models/ippv_model.dart';
import 'package:uke_mlab/models/screen_element_models/theme_model.dart';
import 'package:uke_mlab/utilities/enums/alarm_status.dart';
import 'package:uke_mlab/utilities/enums/sensor.dart';
import 'package:uke_mlab/utilities/enums/screen_status.dart';
import 'package:uke_mlab/utilities/enums/patient_type.dart';
import 'package:uke_mlab/utilities/app_theme.dart';

class SystemState extends GetxController {
  bool scenarioStarted = false;

  screenStatusEnum screenStatus = screenStatusEnum.patientSettingScreen;

  patientTypeEnum patientType = patientTypeEnum.none;

  final RxMap<sensorEnumAbsolute, RxMap<String, dynamic>> alarmState =
      <sensorEnumAbsolute, RxMap<String, dynamic>>{}.obs;

  final GeneralAlarms generalAlarms = GeneralAlarms();

  final GraphList graphList = GraphList();

  final AbsAlarmFieldModel absAlarmFieldModel = AbsAlarmFieldModel();

  final IppvModel ippvModel = IppvModel();

  RxList<bool> selectedToggleView = [true, false, false].obs;

  final ThemeModel themeModel = ThemeModel();

  // SystemState initated with no violations at place and screenStatus as topLevelScreen
  SystemState() {
    for (var sensor in sensorEnumAbsolute.values) {
      alarmState[sensor] = RxMap({
        "priority": 0,
        "message": "none",
        "enum": alarmStatus.none,
        'color': AppTheme.alarmNoneColor,
      });
    }
  }

  void setSelectedToggleView(List<bool> newToggleView) {
    selectedToggleView.value = newToggleView;
    update();
  }
}
