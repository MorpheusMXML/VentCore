import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';

import 'package:uke_mlab/utilities/enums/scenarios.dart';
import 'package:uke_mlab/utilities/enums/sensor.dart';

abstract class AbstractScenario {
  bool scenarioRunning = false;
  late scenariosEnum scenarioType;

  /// Starts a given scenario via the [scenarioPath].
  ///
  /// [scenarioPath] points to the file that contains data.
  /// Calls [loadData] to load the data via the [scenarioPath], after this method calls [runScenario].
  void startScenario({required String scenarioPath}) {
    scenarioRunning = true;
    loadData(scenarioPath: scenarioPath).then((dataList) => runScenario(
        dataMapAbsolute: dataList[0] as Map<sensorEnumAbsolute, Map<String, dynamic>>,
        dataMapGraph: dataList[1] as Map<sensorEnumGraph, Map<String, dynamic>>));
  }

  /// [runScenario] starts a [Timer] that updates each graph and absolute value seperately.
  ///
  /// [dataMapAbsolute] is a map created by [loadData] it holds all information to the used Absoute values in this scenario
  /// [dataMapGraph] is a map created by [loadData] is holds all information to the used [Graph] in this scnario.
  void runScenario(
      {required Map<sensorEnumAbsolute, Map<String, dynamic>> dataMapAbsolute,
      required Map<sensorEnumGraph, Map<String, dynamic>> dataMapGraph});

  void stopScenario() {
    scenarioRunning = false;
  }

  /// Loads data specified by the [scenarioPath] and creates two maps that hold information to the graphs and absolute value tiles respectively, returns a list containing both maps.
  Future<List<Map<dynamic, Map<String, dynamic>>>> loadData({required String scenarioPath}) async {
    Map<sensorEnumAbsolute, Map<String, dynamic>> absoluteMap = {};
    Map<sensorEnumGraph, Map<String, dynamic>> graphMap = {};

    var jsonString = await rootBundle.loadString(scenarioPath);
    var channelList = await jsonDecode(jsonString.toString())['channel_list'];

    for (int i = 0; i < channelList.length; i++) {
      Map<String, dynamic> currentChannel = channelList[i];
      Map<dynamic, dynamic> info = currentChannel['channel_information'];
      if (info['type'] == 'absolute') {
        for (int j = 0; j < sensorEnumAbsolute.values.length; j++) {
          if (sensorEnumAbsolute.values[j].name == info['enum_identifier']) {
            absoluteMap[sensorEnumAbsolute.values[j]] = currentChannel;
            break;
          }
        }
      } else if (info['type'] == 'graph') {
        for (int j = 0; j < sensorEnumGraph.values.length; j++) {
          if (sensorEnumGraph.values[j].name == info['enum_identifier']) {
            graphMap[sensorEnumGraph.values[j]] = currentChannel;
            break;
          }
        }
      } else {
        throw Exception('Channel info type:${info['type']} not found!');
      }
    }
    return [absoluteMap, graphMap];
  }

  /// Calculates the update rate using [batchSize] and [resolution] and returns a [Duration] in milliseconds.
  ///
  /// Where [batchSize] is the amount of values to be updated in one go and
  /// [resolution] is the frequency in Hz that the data is recorded in.
  /// For example 500Hz [resolution] means we have 500 datapoints a second.
  /// ```dart
  /// int millisTillNextBatch = ((1 / resolution) * 1000) * batchSize;
  /// ```
  Duration calculateUpdateRate({required int batchSize, required double resolution}) {
    int millisTillNextDatapoint = ((1 / resolution) * 1000).toInt();
    int millisTillNextBatch = millisTillNextDatapoint * batchSize;
    return Duration(milliseconds: millisTillNextBatch);
  }

  Duration calculateUpdateRateAbsolute({required double resolution}) {
    return calculateUpdateRate(batchSize: 1, resolution: resolution);
  }
}
