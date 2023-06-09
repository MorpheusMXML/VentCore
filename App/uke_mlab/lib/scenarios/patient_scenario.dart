import 'dart:async';

import 'package:get/get.dart';

import 'package:uke_mlab/models/data_models/model_absolute.dart';
import 'package:uke_mlab/models/data_models/model_graph.dart';
import 'package:uke_mlab/models/data_models/model_nibd.dart';
import 'package:uke_mlab/models/system_state.dart';
import 'package:uke_mlab/utilities/enums/non_graph_alarm.dart';
import 'package:uke_mlab/utilities/enums/sensor.dart';
import 'package:uke_mlab/utilities/enums/scenarios.dart';
import 'package:uke_mlab/scenarios/abstract_scenario.dart';

/// This implementation of [AbstractScenario] updates the data until there are no more datapoints at which point it stops.
///
/// {@category Scenarios}
class PatientScenario extends AbstractScenario {
  scenariosEnum scenarioType;

  PatientScenario({
    required this.scenarioType,
  }) : super();

  @override
  void runScenario(
      {required Map<sensorEnumAbsolute, Map<String, dynamic>> dataMapAbsolute,
      required Map<sensorEnumGraph, Map<String, dynamic>> dataMapGraph}) {
    Map<sensorEnumGraph, Map<int, Map<String, dynamic>>> scenarioMap = scenarioType.scenarioMap;

    for (var sensorAbsolute in dataMapAbsolute.keys) {
      // we update these two absolute tile when updating the graph
      if (sensorAbsolute != sensorEnumAbsolute.sysAbsolute && sensorAbsolute != sensorEnumAbsolute.diaAbsolute) {
        DataModelAbsolute dataModelAbsolute = Get.find<DataModelAbsolute>(tag: sensorAbsolute.name);
        double resolution = dataMapAbsolute[sensorAbsolute]!['channel_information']['resolution']['value'].toDouble();
        List<dynamic> dataList = dataMapAbsolute[sensorAbsolute]!['data'];

        if (sensorAbsolute == sensorEnumAbsolute.hfAbsolute) {
          updateHFData(dataList: dataList, resolution: resolution, dataModelAbsolute: dataModelAbsolute);
        } else {
          updateAbsoluteData(dataList: dataList, resolution: resolution, dataModelAbsolute: dataModelAbsolute);
        }
      }
    }

    for (var sensorGraph in dataMapGraph.keys) {
      Map<int, Map<String, dynamic>> graphAlarmMap = scenarioMap[sensorGraph] ?? {};
      int batchSize = 1;
      double resolution = dataMapGraph[sensorGraph]!['channel_information']['resolution']['value'].toDouble();
      List<dynamic> dataList = dataMapGraph[sensorGraph]!['data'];

      if (sensorGraph == sensorEnumGraph.nibd) {
        DataModelNIBD dataModelNIBD = Get.find<DataModelNIBD>(tag: sensorGraph.name);
        DataModelAbsolute sysDataModel = Get.find<DataModelAbsolute>(tag: sensorEnumAbsolute.sysAbsolute.name);
        DataModelAbsolute diaDataModel = Get.find<DataModelAbsolute>(tag: sensorEnumAbsolute.diaAbsolute.name);

        List<dynamic> sysDataList = List<dynamic>.generate(dataList.length, (index) => dataList[index][0]);
        List<dynamic> diaDataList = List<dynamic>.generate(dataList.length, (index) => dataList[index][1]);

        updateNIBD(
          batchSize: batchSize,
          resolution: resolution,
          sysDataList: sysDataList,
          diaDataList: diaDataList,
          dataList: dataList,
          dataModelNIBD: dataModelNIBD,
          sysDataModel: sysDataModel,
          diaDataModel: diaDataModel,
          graphAlarmMap: graphAlarmMap,
        );
      } else {
        DataModelGraph dataModelGraph = Get.find<DataModelGraph>(tag: sensorGraph.name);

        updateGraph(
          batchSize: batchSize,
          resolution: resolution,
          dataList: dataList,
          dataModelGraph: dataModelGraph,
          graphAlarmMap: graphAlarmMap,
        );
      }
    }
  }

  void updateNIBD(
      {required int batchSize,
      required double resolution,
      required List<dynamic> sysDataList,
      required List<dynamic> diaDataList,
      required List dataList,
      required DataModelNIBD dataModelNIBD,
      required DataModelAbsolute sysDataModel,
      required DataModelAbsolute diaDataModel,
      required Map<int, Map<String, dynamic>> graphAlarmMap}) {
    Timer currentTimer;

    currentTimer = Timer.periodic(calculateUpdateRate(batchSize: batchSize, resolution: resolution), (timer) {
      int startIndex = dataModelNIBD.singleData.value.counter;
      int endIndex = dataModelNIBD.singleData.value.counter + batchSize;

      if (graphAlarmMap.containsKey(startIndex)) {
        nonGraphAlarmEnum currentAlarm = graphAlarmMap[startIndex]!['alarm'];
        int currentPriority = graphAlarmMap[startIndex]!['priority'];
        Get.find<SystemState>().generalAlarms.addAlarm(currentAlarm, currentPriority);
      }

      if ((endIndex % dataList.length) == 0) {
        timer.cancel();
      }

      sysDataModel.updateValue(sysDataList[sysDataModel.counter.value].toDouble());
      diaDataModel.updateValue(diaDataList[diaDataModel.counter.value].toDouble());
      dataModelNIBD.updateValues(dataList.sublist(startIndex, endIndex));
    });
    scenarioTimer.add(currentTimer);
  }

  void updateGraph(
      {required int batchSize,
      required double resolution,
      required List<dynamic> dataList,
      required DataModelGraph dataModelGraph,
      required Map<int, Map<String, dynamic>> graphAlarmMap}) {
    Timer currentTimer;

    currentTimer = Timer.periodic(calculateUpdateRate(batchSize: batchSize, resolution: resolution), (timer) {
      int startIndex = dataModelGraph.singleData.value.counter;
      int endIndex = dataModelGraph.singleData.value.counter + batchSize;

      if (graphAlarmMap.containsKey(startIndex)) {
        nonGraphAlarmEnum currentAlarm = graphAlarmMap[startIndex]!['alarm'];
        int currentPriority = graphAlarmMap[startIndex]!['priority'];
        Get.find<SystemState>().generalAlarms.addAlarm(currentAlarm, currentPriority);
      }

      if ((endIndex % dataList.length) == 0) {
        timer.cancel();
      }
      dataModelGraph.updateValues(dataList.sublist(startIndex, endIndex));
    });
    scenarioTimer.add(currentTimer);
  }

  void updateHFData(
      {required List<dynamic> dataList, required double resolution, required DataModelAbsolute dataModelAbsolute}) {
    Timer currentTimer;

    currentTimer = Timer.periodic(calculateUpdateRateAbsolute(resolution: resolution), (timer) {
      if ((dataModelAbsolute.counter.value == (dataList.length - 1))) {
        timer.cancel();
      }
      Get.find<DataModelAbsolute>(tag: sensorEnumAbsolute.pulse.name)
          .updateValue((dataList[dataModelAbsolute.counter.value] * 0.98).toDouble());
      dataModelAbsolute.updateValue(dataList[dataModelAbsolute.counter.value].toDouble());
    });
    scenarioTimer.add(currentTimer);
  }

  void updateAbsoluteData(
      {required List<dynamic> dataList, required double resolution, required DataModelAbsolute dataModelAbsolute}) {
    Timer currentTimer;

    currentTimer = Timer.periodic(calculateUpdateRateAbsolute(resolution: resolution), (timer) {
      if ((dataModelAbsolute.counter.value == (dataList.length - 1))) {
        timer.cancel();
      }

      dataModelAbsolute.updateValue(dataList[dataModelAbsolute.counter.value].toDouble());
    });
    scenarioTimer.add(currentTimer);
  }
}
