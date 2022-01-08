import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/utilities/enums/sensor.dart';
import 'package:uke_mlab/utilities/enums/scenarios.dart';
import 'package:uke_mlab/models/model.dart';
import 'package:uke_mlab/scenarios/abstract_scenario.dart';

class StandardScenario extends AbstractScenario {
  StandardScenario({
    scenarioType = scenariosEnum.standardScenario,
  }) : super();

  //TODO: put into abstract class if we get values => use path as argument
  @override
  Future<Map<sensorEnum, List<dynamic>>> loadData() async {
    Map<sensorEnum, List<dynamic>> returnMap = {};
    var jsonString = await rootBundle.loadString('assets/jsons/data.json');
    var source = await jsonDecode(jsonString.toString())["data"];
    returnMap = {
      //TODO: numbers dont match sensors at the moment
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
      DataModel dataModel = Get.find<DataModel>(tag: sensor.name);

      Timer.periodic(Duration(milliseconds: sensor.updateRate * 100), (timer) {
        var dataList = dataMap[sensor]!;

        if (!scenarioRunning) {
          timer.cancel();
        }
        dataModel.updateValueList(dataList.sublist(
            dataModel.singleData.value.counter % dataList.length - 1,
            (dataModel.singleData.value.counter + 100) % dataList.length - 1));
      });
    }
  }
}
