import 'dart:async';

import 'package:get/get.dart';

import 'package:uke_mlab/models/data_models/model_absolute.dart';
import 'package:uke_mlab/models/data_models/model_graph.dart';
import 'package:uke_mlab/models/data_models/model_nibd.dart';
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
      // we update these two absolute tile when updating the graph
      if (sensorAbsolute != sensorEnumAbsolute.sysAbsolute &&
          sensorAbsolute != sensorEnumAbsolute.diaAbsolute) {
        DataModelAbsolute dataModelAbsolute =
            Get.find<DataModelAbsolute>(tag: sensorAbsolute.name);
        double resolution =
            dataMapAbsolute[sensorAbsolute]!['channel_information']
                    ['resolution']['value']
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

          dataModelAbsolute.updateValue(
              dataList[dataModelAbsolute.counter.value].toDouble());
        });
      }
    }

    for (var sensorGraph in dataMapGraph.keys) {
      int batchSize = 1;
      double resolution = dataMapGraph[sensorGraph]!['channel_information']
              ['resolution']['value']
          .toDouble();
      List<dynamic> dataList = dataMapGraph[sensorGraph]!['data'];

      if (sensorGraph == sensorEnumGraph.nibd) {
        DataModelNIBD dataModelNIBD =
            Get.find<DataModelNIBD>(tag: sensorGraph.name);
        DataModelAbsolute sysDataModel = Get.find<DataModelAbsolute>(
            tag: sensorEnumAbsolute.sysAbsolute.name);
        DataModelAbsolute diaDataModel = Get.find<DataModelAbsolute>(
            tag: sensorEnumAbsolute.diaAbsolute.name);

        List<dynamic> sysDataList = List<dynamic>.generate(
            dataList.length, (index) => dataList[index][0]);
        List<dynamic> diaDataList = List<dynamic>.generate(
            dataList.length, (index) => dataList[index][1]);

        updateNIBD(
          batchSize: batchSize,
          resolution: resolution,
          sysDataList: sysDataList,
          diaDataList: diaDataList,
          dataList: dataList,
          dataModelNIBD: dataModelNIBD,
          sysDataModel: sysDataModel,
          diaDataModel: diaDataModel,
        );
      } else {
        DataModelGraph dataModelGraph =
            Get.find<DataModelGraph>(tag: sensorGraph.name);

        updateGraph(
          batchSize: batchSize,
          resolution: resolution,
          dataList: dataList,
          dataModelGraph: dataModelGraph,
        );
      }
    }
  }

  void updateGraph(
      {required int batchSize,
      required double resolution,
      required List<dynamic> dataList,
      required DataModelGraph dataModelGraph}) {
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
        endIndex = dataList.length;
        scenarioRunning = false;
      }
      dataModelGraph.updateValues(dataList.sublist(startIndex, endIndex));
    });
  }

  void updateNIBD(
      {required int batchSize,
      required double resolution,
      required List<dynamic> sysDataList,
      required List<dynamic> diaDataList,
      required List dataList,
      required DataModelNIBD dataModelNIBD,
      required DataModelAbsolute sysDataModel,
      required DataModelAbsolute diaDataModel}) {
    Timer.periodic(
        calculateUpdateRate(batchSize: batchSize, resolution: resolution),
        (timer) {
      int startIndex = dataModelNIBD.singleData.value.counter;
      int endIndex = dataModelNIBD.singleData.value.counter + batchSize;

      if (dataList.length <= startIndex) {
        scenarioRunning = false;
      }
      if (!scenarioRunning) {
        timer.cancel();
      }

      sysDataModel
          .updateValue(sysDataList[sysDataModel.counter.value].toDouble());
      diaDataModel
          .updateValue(diaDataList[diaDataModel.counter.value].toDouble());

      if (endIndex >= dataList.length) {
        endIndex = dataList.length;
        scenarioRunning = false;
      }
      dataModelNIBD.updateValues(dataList.sublist(startIndex, endIndex));
    });
  }
}
