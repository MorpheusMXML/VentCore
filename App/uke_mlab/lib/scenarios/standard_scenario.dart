import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/models/enums.dart';
import 'package:uke_mlab/models/model.dart';
import 'package:uke_mlab/scenarios/abstract_scenario.dart';

class StandardScenario extends AbstractScenario {
  StandardScenario({
    scenarioType = scenariosEnum.standardScenario,
  }) : super();

  //TODO put into abstract class if we get values => use path as argument
  @override
  Future<Map<sensorEnum, List<dynamic>>> loadData() async {
    Map<sensorEnum, List<dynamic>> returnMap = {};
    var jsonString = await rootBundle.loadString('assets/data.json');
    var source = await jsonDecode(jsonString.toString())["data"];
    returnMap = {
      //numbers dont match sensors at the moment
      sensorEnum.breathFrequency: source[0]["data"],
      sensorEnum.co2: source[1]["data"],
      sensorEnum.heartFrequency: source[8]["data"],
      sensorEnum.mve: source[3]["data"],
      sensorEnum.nibd: source[4]["data"],
      sensorEnum.pulse: source[5]["data"],
      sensorEnum.spo2: source[7]["data"]
    };
    return returnMap;
  }

  @override
  void runScenario(Map<sensorEnum, List<dynamic>> dataMap) {
    for (var sensor in sensorEnum.values) {
      int updateRate = 500;
      DataModel dataModel = Get.find<DataModel>(tag: sensor.toString());

      if (updateRates.containsKey(sensor.toString())) {
        updateRate = updateRates[sensor.toString()];
      }
      Timer.periodic(Duration(milliseconds: updateRate), (timer) {
        if (!scenarioRunning) {
          print('[Standard Scenario] scenarioRunning is false');
          timer.cancel();
        }
        dataModel.updateValueList(dataMap[sensor]!.sublist(
            dataModel.singleData.value.counter,
            dataModel.singleData.value.counter + 50));
        //dataModel.updateValues(dataMap[sensor]![dataModel.singleData.value.counter]);
      });
    }
  }
}
