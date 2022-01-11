import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/utilities/enums/sensor.dart';
import 'package:uke_mlab/utilities/enums/scenarios.dart';
import 'package:uke_mlab/models/model.dart';
import 'package:uke_mlab/scenarios/abstract_scenario.dart';

class Scenario1 extends AbstractScenario {
  Scenario1({
    scenarioType = scenariosEnum.scenario1,
  }) : super();

  @override
  Future<Map<sensorEnum, Map<dynamic, dynamic>>> loadData() async {
    Map<sensorEnum, Map<dynamic, dynamic>> returnMap = {};

    var jsonString =
        await rootBundle.loadString('assets/jsons/standard_scenario.json');
    var channelList = await jsonDecode(jsonString.toString())["channel_list"];

    for (int i = 0; i < channelList.length; i++) {
      var currentChannel = channelList[i];
      //intermediate key, breathFreq. will be overidden
      sensorEnum key = sensorEnum.breathFrequency;
      Map<dynamic, dynamic> info = currentChannel['channel_information'];

      for (int j = 0; j < sensorEnum.values.length; j++) {
        //TODO: differentiate between graph and absolute?
        if (sensorEnum.values[j].name == info['enum_identifier']) {
          key = sensorEnum.values[j];
          break;
        }
      }
      returnMap[key] = currentChannel;
    }
    return returnMap;
  }

  @override
  void runScenario(Map<sensorEnum, Map<dynamic, dynamic>> dataMap) {
    for (var sensor in dataMap.keys) {
      // why sensor.toString() and not sensor.name -> problem?
      DataModel dataModel = Get.find<DataModel>(tag: sensor.toString());

      var impulseach =
          (1 / dataMap[sensor]!['channel_information']['resolution']['value']);
      Duration duration;

      if (impulseach < 1) {
        duration = Duration(milliseconds: (impulseach * 100).toInt());
      } else {
        duration = Duration(seconds: impulseach.toInt());
      }

      Timer.periodic(duration, (timer) {
        var dataList = dataMap[sensor]!['data'];

        if (!scenarioRunning) {
          timer.cancel();
        }
        //TODO: understand what happens here
        dataModel.updateValueList(dataList.sublist(
            dataModel.singleData.value.counter % (dataList.length - 1),
            (dataModel.singleData.value.counter + 100) %
                (dataList.length - 1)));
      });
    }
  }
}
