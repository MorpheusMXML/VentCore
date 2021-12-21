import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/models/enums.dart';
import 'package:uke_mlab/models/model.dart';
import 'package:uke_mlab/scenarios/abstract_scenario.dart';

class StandardScenario extends AbstractScenario {
  var dataMap = {};

  StandardScenario() : super();

  @override
  Future<void> loadData() async {
    loading = true;
    var jsonString = await rootBundle.loadString('assets/data.json');
    var source = await jsonDecode(jsonString.toString())["data"];
    dataMap = {
      sensorEnum.breathFrequency: source[0],
      sensorEnum.co2: source[1],
      sensorEnum.heartFrequency: source[8],
      sensorEnum.mve: source[3],
      sensorEnum.nibd: source[4],
      sensorEnum.pulse: source[5],
      sensorEnum.spo2: source[7]
    };
    loading = false;
  }

  @override
  void runScenario() {
    for (var sensor in sensorEnum.values) {
      int updateRate = 500;
      DataModel dataModel = Get.find<DataModel>(tag: sensor.toString());

      if (updateRates.containsKey(sensor.toString())) {
        updateRate = updateRates[sensor.toString()];
      }
      Timer.periodic(Duration(milliseconds: updateRate), (timer) {
        if (!scenarioRunning) {
          timer.cancel();
        }
        //TODO load actual values for update
        dataModel.updateValues(10);
      });
    }
  }
}
