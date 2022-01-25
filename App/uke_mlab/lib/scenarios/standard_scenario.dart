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

/// This implementation of [AbstractScenario] allows the data to loop and never end.
class StandardScenario extends AbstractScenario {
  StandardScenario({
    scenarioType = scenariosEnum.standardScenario,
  }) : super();

  @override
  void runScenario(
      {required Map<sensorEnumAbsolute, Map<String, dynamic>> dataMapAbsolute,
      required Map<sensorEnumGraph, Map<String, dynamic>> dataMapGraph}) {
    Map<sensorEnumGraph, Map<int, Map<String, dynamic>>> scenarioMap = scenariosEnum.standardScenario.scenarioMap;

    // init mve & breathFreq values
    Get.find<DataModelAbsolute>(tag: sensorEnumAbsolute.breathfrequency.name)
        .updateValue(Get.find<SystemState>().ippvModel.defaultIppvValues['Freq.']!.toDouble());
    Get.find<DataModelAbsolute>(tag: sensorEnumAbsolute.mve.name).updateValue(
        Get.find<SystemState>().ippvModel.defaultIppvValues['Freq.']! *
            (Get.find<SystemState>().ippvModel.defaultIppvValues['Vt']! / 1000));

    for (var sensorAbsolute in dataMapAbsolute.keys) {
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

  /// Updates the [DataModelNIBD] seperately from the [dataModelGraph].
  /// Also updates the [DataModelAbsolute] for [sysDataModel] and [diaDataModel].
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

      if (dataList.length == sysDataModel.counter.value) {
        sysDataModel.counter.value = 0;
        diaDataModel.counter.value = 0;
      }
      sysDataModel.updateValue(sysDataList[sysDataModel.counter.value].toDouble());
      diaDataModel.updateValue(diaDataList[diaDataModel.counter.value].toDouble());

      if (graphAlarmMap.containsKey(startIndex)) {
        nonGraphAlarmEnum currentAlarm = graphAlarmMap[startIndex]!['alarm'];
        int currentPriority = graphAlarmMap[startIndex]!['priority'];
        Get.find<SystemState>().generalAlarms.addAlarm(currentAlarm, currentPriority);
      }

      if ((endIndex % dataList.length) == 0) {
        dataModelNIBD.updateValues(dataList.sublist(startIndex % dataList.length, dataList.length));
      } else {
        dataModelNIBD.updateValues(dataList.sublist((startIndex % dataList.length), (endIndex % dataList.length)));
      }
    });
    scenarioTimer.add(currentTimer);
  }

  /// Updates the [DataModelGraph] for each graph that received data in this scenario, allows for looping.
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
        dataModelGraph.updateValues(dataList.sublist(startIndex % dataList.length, dataList.length));
      } else {
        dataModelGraph.updateValues(dataList.sublist((startIndex % dataList.length), (endIndex % dataList.length)));
      }
    });
    scenarioTimer.add(currentTimer);
  }

  /// Seperately updates the [DataModelAbsolute] for the heartfrequency and pulse, allows for looping.
  void updateHFData(
      {required List<dynamic> dataList, required double resolution, required DataModelAbsolute dataModelAbsolute}) {
    Timer currentTimer;

    currentTimer = Timer.periodic(calculateUpdateRateAbsolute(resolution: resolution), (timer) {
      if (dataList.length == dataModelAbsolute.counter.value) {
        dataModelAbsolute.counter.value = 0;
      }
      if (!scenarioRunning) {
        timer.cancel();
      }
      Get.find<DataModelAbsolute>(tag: sensorEnumAbsolute.pulse.name)
          .updateValue((dataList[dataModelAbsolute.counter.value] * 0.98).toDouble());
      dataModelAbsolute.updateValue(dataList[dataModelAbsolute.counter.value].toDouble());
    });
    scenarioTimer.add(currentTimer);
  }

  /// Normal update function for [DataModelAbsolute] allows for looping.
  void updateAbsoluteData(
      {required List<dynamic> dataList, required double resolution, required DataModelAbsolute dataModelAbsolute}) {
    Timer currentTimer;

    currentTimer = Timer.periodic(calculateUpdateRateAbsolute(resolution: resolution), (timer) {
      if (dataList.length == dataModelAbsolute.counter.value) {
        dataModelAbsolute.counter.value = 0;
      }
      if (!scenarioRunning) {
        timer.cancel();
      }

      dataModelAbsolute.updateValue(dataList[dataModelAbsolute.counter.value].toDouble());
    });
    scenarioTimer.add(currentTimer);
  }
}
