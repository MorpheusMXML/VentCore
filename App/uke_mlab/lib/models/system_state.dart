import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/models/general_alarms.dart';
import 'package:uke_mlab/utilities/enums/sensor.dart';
import 'package:uke_mlab/utilities/enums/boundary_state.dart';
import 'package:uke_mlab/utilities/enums/screen_status.dart';
import 'package:uke_mlab/utilities/enums/patient_type.dart';
import 'package:uke_mlab/utilities/app_theme.dart';

class SystemState {
  screenStatusEnum screenStatus = screenStatusEnum.patientSettingScreen;
  patientTypeEnum patientType = patientTypeEnum.none;
  final RxMap<sensorEnum, boundaryStateEnum> violationStates =
      <sensorEnum, boundaryStateEnum>{}.obs;
  bool scenarioStarted = false;

  // More or less copy pasted from old mockup class
  RxList<sensorEnum> graphList = <sensorEnum>[].obs;

  RxBool addGraph = false.obs;

  Map<String, RxInt> ippvValues = {
    'Freq.': 20.obs,
    'Vt': 40.obs,
    'PEEP': 60.obs
  };

  final GeneralAlarms generalAlarms = GeneralAlarms();

  void updateIPPVValue(String name, int value) {
    ippvValues[name]!.value = ippvValues[name]!.value + value;
  }

  RxList<bool> selectedToggleView = [true, false, false].obs;

  // TODO: Save differently? Use local storage to permanently save this setting?
  RxBool isDarkMode = true.obs;
  Rx<Icon> icon = const Icon(Icons.dark_mode).obs;

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

  // SystemState initated with no violations at place and screenStatus as topLevelScreen
  SystemState() {
    for (var sensor in sensorEnum.values) {
      violationStates[sensor] = boundaryStateEnum.inBoundaries;
    }
  }
}
