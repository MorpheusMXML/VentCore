import 'package:flutter/services.dart';
import 'dart:convert';

import 'package:get/get.dart';

import 'package:uke_mlab/models/enums.dart';
import 'package:uke_mlab/models/model.dart';

abstract class AbstractScenario {
  bool scenarioRunning = false;
  bool loading = true;

  late final Map<String, dynamic> updateRates;

  AbstractScenario() {
    loadUpdateRates();
  }

  void loadUpdateRates() async {
    var updateRateString =
        await rootBundle.loadString('assets/jsons/sensor_update_rates.json');
    updateRates = await jsonDecode(updateRateString.toString());
  }

  void startScenario() {
    scenarioRunning = true;
    loadData().then((dataMap) => runScenario(dataMap));
  }

  //to be overwritten, behaviour depending on concrete scenario
  void runScenario(Map<sensorEnum, List<dynamic>> dataMap);

  void stopScenario() {
    scenarioRunning = false;
  }

  //to be implemented in respect to scenario
  Future<Map<sensorEnum, List<dynamic>>> loadData();

  //maybe subject to deletion depending on future decisions
  void updateData(sensorEnum sensor, double value) {
    Get.find<DataModel>(tag: sensor.toString()).updateValues(value);
  }
}
