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
    loadData();
  }

  void loadUpdateRates() async {
    var updateRateString =
        await rootBundle.loadString('assets/jsons/sensor_update_rates.json');
    updateRates = await jsonDecode(updateRateString.toString());
  }

  void startScenario() {
    scenarioRunning = true;
    //TODO: add wait until !loading
    runScenario();
  }

  //to be overwritten, behaviour depending on concrete scenario
  void runScenario();

  void stopScenario() {
    scenarioRunning = false;
  }

  //to be implemented in respect to scenario
  Future<void> loadData();

  //maybe subject to deletion depending on future decisions
  void updateData(sensorEnum sensor, double value) {
    Get.find<DataModel>(tag: sensor.toString()).updateValues(value);
  }
}
