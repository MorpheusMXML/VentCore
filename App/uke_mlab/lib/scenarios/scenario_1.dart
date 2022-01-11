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
  Future<Map<sensorEnum, Map<String, dynamic>>> loadData() async {
    Map<sensorEnum, Map<String, dynamic>> returnMap = {};

    var jsonString =
        await rootBundle.loadString('assets/jsons/standard_scenario.json');
    var channelList = await jsonDecode(jsonString.toString())["channel_list"];

    for (int i = 0; i < channelList.length; i++) {
      Map<String, dynamic> currentChannel = channelList[i];
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
  void runScenario(Map<sensorEnum, Map<String, dynamic>> dataMap) {
    for (var sensor in dataMap.keys) {
      DataModel dataModel = Get.find<DataModel>(tag: sensor.name);
      int batchSize = 1;
      double resolution = dataMap[sensor]!['channel_information']['resolution']
              ['value']
          .toDouble();

      Timer.periodic(
          calculateUpdateRate(batchSize: batchSize, resolution: resolution),
          (timer) {
        var dataList = dataMap[sensor]!['data'];
        var dataListLength = dataList.length;

        if (!scenarioRunning) {
          timer.cancel();
        }
        dataModel.updateValueList(dataList.sublist(
            dataModel.singleData.value.counter % (dataListLength - 1),
            (dataModel.singleData.value.counter + batchSize) %
                (dataListLength - 1)));
      });
    }
  }

  /// Calculates the update rate using [batchSize] and [batchSize] and returns a [Duration] in milliseconds.
  ///
  /// Where [batchSize] is the amount of values to be updated in one go and
  /// [resolution] is the frequency in Hz that the data is recorded in.
  /// For example 500Hz [resolution] means we have 500 datapoints a second.
  /// ```dart
  /// int millisTillNextBatch = ((1 / resolution) * 1000) * batchSize;
  /// ```
  Duration calculateUpdateRate(
      {required int batchSize, required double resolution}) {
    int millisTillNextDatapoint = ((1 / resolution) * 1000).toInt();
    int millisTillNextBatch = millisTillNextDatapoint * batchSize;
    return Duration(milliseconds: millisTillNextBatch);
  }
}
