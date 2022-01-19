import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/models/screen_element_models/general_alarms.dart';
import 'package:uke_mlab/models/screen_element_models/absolute_alarm_field_model.dart';
import 'package:uke_mlab/utilities/enums/alarm_status.dart';
import 'package:uke_mlab/utilities/enums/sensor.dart';
import 'package:uke_mlab/utilities/enums/screen_status.dart';
import 'package:uke_mlab/utilities/enums/patient_type.dart';
import 'package:uke_mlab/utilities/app_theme.dart';

class SystemState {
  screenStatusEnum screenStatus = screenStatusEnum.patientSettingScreen;

  patientTypeEnum patientType = patientTypeEnum.none;

  final RxMap<sensorEnumAbsolute, RxMap<String, dynamic>> alarmState =
      <sensorEnumAbsolute, RxMap<String, dynamic>>{}.obs;

  bool scenarioStarted = false;

  // More or less copy pasted from old mockup class
  RxList<sensorEnumGraph> graphList = <sensorEnumGraph>[].obs;

  RxList<sensorEnumAbsolute> activeGraphAbsolutes = <sensorEnumAbsolute>[].obs;

  RxBool addGraph = false.obs;

  final GeneralAlarms generalAlarms = GeneralAlarms();
  final AbsAlarmFieldModel absAlarmFieldModel = AbsAlarmFieldModel();

  Map<String, RxInt> ippvValues = {
    'Freq.': 20.obs,
    'Vt': 40.obs,
    'PEEP': 60.obs
  };

  final RxBool ippvTapped = false.obs;
  final RxString selectedIPPVMode = 'Mode1'.obs;

  RxList<bool> selectedToggleView = [true, false, false].obs;

  // TODO: Save differently? Use local storage to permanently save this setting?
  RxBool isDarkMode = true.obs;

  Rx<Icon> icon = const Icon(Icons.dark_mode).obs;

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

  void toggleTheme() {
    if (isDarkMode.value) {
      Get.changeTheme(AppTheme.lightTheme);
      isDarkMode.toggle();
      icon.value = const Icon(Icons.light_mode_rounded);
    } else {
      Get.changeTheme(AppTheme.darkTheme);
      isDarkMode.toggle();
      icon.value = const Icon(Icons.dark_mode_rounded);
    }
  }

  void updateIPPVValue(String name, int value) {
    ippvValues[name]!.value = ippvValues[name]!.value + value;
  }

  void graphListAdd(sensorEnumGraph graphKey) {
    evaluateActiveGraphAbsolutes();
    graphList.add(graphKey);
  }

  void graphListRemove(sensorEnumGraph graphKey) {
    evaluateActiveGraphAbsolutes();
    graphList.remove(graphKey);
  }

  void graphListSet(List<sensorEnumGraph> newList) {
    evaluateActiveGraphAbsolutes();
    graphList.value = newList;
  }

  void evaluateActiveGraphAbsolutes() {
    activeGraphAbsolutes.clear();
    for (var graphSensorKey in graphList) {
      sensorEnumAbsolute? sensorKey = SensorMapping.sensorMap[graphSensorKey];
      if (sensorKey != null &&
          (alarmState[sensorKey]!["enum"] != alarmStatus.none &&
              alarmState[sensorKey]!["enum"] != alarmStatus.confirmed)) {
        activeGraphAbsolutes.add(sensorKey);
      }
    }
  }
}
