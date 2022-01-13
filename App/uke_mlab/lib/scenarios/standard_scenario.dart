import 'dart:async';

import 'package:get/get.dart';

import 'package:uke_mlab/models/model_absolute.dart';
import 'package:uke_mlab/models/model_graph.dart';
import 'package:uke_mlab/utilities/enums/sensor.dart';
import 'package:uke_mlab/utilities/enums/scenarios.dart';
import 'package:uke_mlab/scenarios/abstract_scenario.dart';

class StandardScenario extends AbstractScenario {
  StandardScenario({
    scenarioType = scenariosEnum.standardScenario,
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
        // TODO: intermediate implementation -> fix later
        if (dataList.length - 1 == dataModelAbsolute.counter.value) {
          dataModelAbsolute.counter.value = 0;
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

        if (!scenarioRunning) {
          timer.cancel();
        }

        // careful with sublist start inclusive end exclusive
        // case: start is inside list.length but end overflows
        if (endIndex > dataList.length - 1 &&
            startIndex < dataList.length - 1) {
          List endOfList = dataList.sublist(startIndex, dataList.length);
          // may discard last value
          List startOfList =
              dataList.sublist(0, endIndex + 1 % dataList.length - 1);

          dataModelGraph.updateValues(endOfList + startOfList);
        } else if (startIndex > dataList.length - 1) {
          dataModelGraph.updateValues(dataList.sublist(
              startIndex % dataList.length - 1,
              endIndex + 1 % dataList.length - 1));
        } else {
          dataModelGraph.updateValues(dataList.sublist(startIndex, endIndex));
        }
      });
    }
  }
}
