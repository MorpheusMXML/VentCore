import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:uke_mlab/utilities/enums/sensor.dart';
import 'model_graphdata.dart';

/// graphData INCLUDES the singleData value at the end
/// Alarm evaluation is done in alarm_controller
/// graphDataMaxLength is initialized with 100, can be manipulated
class DataModelGraph extends GetxController {
  final sensorEnumGraph sensorKey;

  String graphTitle = "No default title";
  String yAxisTitle = "No default yAxisTitle";
  String xAxisTitle = "No default xAxisTitle";
  Color color = Colors.white;

  ChartSeriesController? chartController;

  late final Rx<ChartData> singleData;

  final RxList<ChartData> graphData = <ChartData>[].obs;
  int graphDataMaxLength = 0;

  DataModelGraph({required this.sensorKey}) {
    if (sensorKey == sensorEnumGraph.cpr) {
      singleData = ChartData.asCPR(time: DateTime.now(), counter: 0, value: 0.0).obs;
    } else {
      singleData = ChartData(time: DateTime.now(), value: 0.0, counter: 0).obs;
    }
  }

  void updateValues(List<dynamic> valueList) {
    //Check wether Data loaded is from CPR Sensor. To Change Constructor Call for ChartData to ChartData.asCPR
    if (sensorKey == sensorEnumGraph.cpr) {
      for (int i = 0; i < valueList.length; i++) {
        singleData.value = ChartData.asCPR(time: DateTime.now(), value: valueList[i].toDouble(), counter: singleData.value.counter + 1);
        graphData.add(singleData.value);
      }

      if (graphData.length + 1 > graphDataMaxLength) {
        for (var i = 0; i < valueList.length; i++) {
          graphData.removeAt(0);
        }
      }
    } else {
      for (int i = 0; i < valueList.length; i++) {
        singleData.value = ChartData(time: DateTime.now(), value: valueList[i].toDouble(), counter: singleData.value.counter + 1);
        graphData.add(singleData.value);
      }

      if (graphData.length + 1 > graphDataMaxLength) {
        for (var i = 0; i < valueList.length; i++) {
          graphData.removeAt(0);
        }
      }
    }

    // update only added/removed indexes instead of the whole chart (efficient)
    // chartController?.updateDataSource(updatedDataIndexes: [for (int i = 0; i < graphData.length; i++) i]);

    // TODO make "little" analysis here and call inform alarmManager to start evaluation
  }

  // informs alarmController about change via call
  void informAlarmController() {
    // TODO: implement
  }

  void populateGraphList() {
    //singleData.value = ChartData(DateTime.now(), 0.0, 0);
    //graphData.add(singleData.value);
    for (int i = 0; i < graphDataMaxLength; i++) {
      singleData.value = ChartData(counter: i, time: DateTime.now(), value: 0.0);
      graphData.add(singleData.value);
    }
  }

  void resetDataModel() {
    singleData.value = ChartData(time: DateTime.now(), value: 0.0, counter: 0);
    //clear historical data
    graphData.clear();
    populateGraphList();
  }

  void setGraphMaxLength(int newLength) {
    graphDataMaxLength = newLength;
    graphData.clear();
    populateGraphList();
  }
}
/* // Construct a new data entry tuple
class ChartData {
  final DateTime time;
  final double value;
  final int counter;

  ChartData(this.time, this.value, this.counter);
} */
