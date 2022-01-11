import 'package:get/get.dart';

import 'package:uke_mlab/utilities/enums/scenarios.dart';
import 'package:uke_mlab/utilities/enums/sensor.dart';
import 'package:uke_mlab/models/model.dart';

abstract class AbstractScenario {
  bool scenarioRunning = false;
  late scenariosEnum scenarioType;

  void startScenario() {
    scenarioRunning = true;
    loadData().then((dataMap) => runScenario(dataMap));
  }

  //to be overwritten, behaviour depending on concrete scenario
  void runScenario(Map<sensorEnum, Map<String, dynamic>> dataMap);

  void stopScenario() {
    scenarioRunning = false;
  }

  //to be implemented in respect to scenario
  Future<Map<sensorEnum, Map<String, dynamic>>> loadData();

  // TODO: Evaluate Deletion @Arne "maybe subject to deletion depending on future decisions"
  void updateData(sensorEnum sensor, double value) {
    Get.find<DataModel>(tag: sensor.name).updateValues(value);
  }
}
