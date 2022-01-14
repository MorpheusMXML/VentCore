import 'dart:async';

import 'package:get/get.dart';

import 'package:uke_mlab/models/model_absolute.dart';
import 'package:uke_mlab/models/model_graph.dart';
import 'package:uke_mlab/utilities/enums/sensor.dart';
import 'package:uke_mlab/utilities/enums/scenarios.dart';
import 'package:uke_mlab/scenarios/abstract_scenario.dart';

class PatientScenario extends AbstractScenario {
  PatientScenario({
    scenarioType = scenariosEnum.scenario1,
  }) : super();

  @override
  void runScenario(
      {required Map<sensorEnumAbsolute, Map<String, dynamic>> dataMapAbsolute,
      required Map<sensorEnumGraph, Map<String, dynamic>> dataMapGraph}) {
    for (var sensorAbsolute in dataMapAbsolute.keys) {
      DataModelAbsolute dataModelAbsolute =
          Get.find<DataModelAbsolute>(tag: sensorAbsolute.name);
      double resolution =
          dataMapAbsolute[sensorAbsolute]!['channel_information']['resolution']
                  ['value']
              .toDouble();
      List<dynamic> dataList = dataMapAbsolute[sensorAbsolute]!['data'];

      Timer.periodic(calculateUpdateRateAbsolute(resolution: resolution),
          (timer) {
        if (dataList.length == dataModelAbsolute.counter.value) {
          scenarioRunning = false;
        }
        if (!scenarioRunning) {
          timer.cancel();
        }

        dataModelAbsolute
            .updateValue(dataList[dataModelAbsolute.counter.value].toDouble());
      });
    }

    for (var sensorGraph in dataMapGraph.keys) {
      DataModelGraph dataModelGraph =
          Get.find<DataModelGraph>(tag: sensorGraph.name);
      int batchSize = 1;
      double resolution = dataMapGraph[sensorGraph]!['channel_information']
              ['resolution']['value']
          .toDouble();
      List<dynamic> dataList = dataMapGraph[sensorGraph]!['data'];

      Timer.periodic(
          calculateUpdateRate(batchSize: batchSize, resolution: resolution),
          (timer) {
        int startIndex = dataModelGraph.singleData.value.counter;
        int endIndex = dataModelGraph.singleData.value.counter + batchSize;

        if (dataList.length <= startIndex) {
          scenarioRunning = false;
        }
        if (!scenarioRunning) {
          timer.cancel();
        }

        if (endIndex >= dataList.length) {
          endIndex = dataList.length - 1;
          scenarioRunning = false;
        }

        dataModelGraph.updateValues(dataList.sublist(startIndex, endIndex));
      });
    }
  }
}
