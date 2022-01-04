import 'dart:async';

import 'package:get/get.dart';
import 'package:uke_mlab/models/enums.dart';
import 'package:uke_mlab/models/model.dart';
// Atm unused
// TODO address in DataModel update/set methods
// TODO use in use in AlarmController

class SystemState {
  screenStatusEnum screenStatus = screenStatusEnum.topLevelScreen;
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

  RxString alarmMessage = ''.obs;

  void updateIPPVValue(String name, int value) {
    ippvValues[name]!.value = ippvValues[name]!.value + value;
  }

  void switchToAlarm(int type) {
    // if ((allGraphs[type]['alarm'] as RxString).value == 'none') {
    //   (allGraphs[type]['alarm'] as RxString).value = 'alarm';
  }

  // SystemState initated with no violations at place and screenStatus as topLevelScreen
  SystemState() {
    for (var sensor in sensorEnum.values) {
      violationStates[sensor] = boundaryStateEnum.inBoundaries;
    }
  }
}
