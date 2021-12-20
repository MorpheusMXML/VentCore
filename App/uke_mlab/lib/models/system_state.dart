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
  final Map<sensorEnum, boundaryStateEnum> violationStates = {};
  bool scenarioStarted = false;
  List<sensorEnum> graphList = [
    sensorEnum.heartFrequency,
    sensorEnum.spo2,
    sensorEnum.co2
  ];

  void activateTimer() {
    for (var sensor in sensorEnum.values) {
      DataModel dataModel = Get.find<DataModel>(tag: sensor.toString());
      Timer.periodic(const Duration(milliseconds: 500), (timer) {
        dataModel.updateValues();
      });
    }
  }

  // SystemState initated with no violations at place and screenStatus as topLevelScreen
  SystemState() {
    for (var sensor in sensorEnum.values) {
      violationStates[sensor] = boundaryStateEnum.inBoundaries;
    }
  }
}
