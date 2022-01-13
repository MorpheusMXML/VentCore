import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:uke_mlab/utilities/enums/sensor.dart';

/// graphData INCLUDES the singleData value at the end
/// Alarm evaluation is done in alarm_controller
/// graphDataMaxLength is initialized with 100, can be manipulated
class DataModelGraph extends GetxController {
  final sensorEnumGraph sensorKey;

  String graphTitle = "No default title";
  String yAxisTitle = "No default yAxisTitle given";
  String xAxisTitle = "No default xAxisTitle given";
  Color color = Colors.white;

  ChartSeriesController? chartController;

  late final Rx<ChartData> singleData;

  final RxList<ChartData> graphData = <ChartData>[].obs;
  int graphDataMaxLength = 1500;

  DataModelGraph({required this.sensorKey}) {
    singleData = ChartData(DateTime.now(), 0.0, 0).obs;
  }

  void updateValues(List<dynamic> valueList) {
    for (int i = 0; i < valueList.length; i++) {
      singleData.value = ChartData(DateTime.now(), valueList[i].toDouble(),
          singleData.value.counter + 1);
      graphData.add(singleData.value);
    }

    if (graphData.length + 1 > graphDataMaxLength) {
      for (var i = 0; i < valueList.length; i++) {
        graphData.removeAt(0);
      }
    }

    // update only added/removed indexes instead of the whole chart (efficient)
    chartController?.updateDataSource(
        updatedDataIndexes: [for (int i = 0; i < graphData.length; i++) i]);

    // TODO make "little" analysis here and call inform alarmManager to start evaluation
  }

  // informs alarmController about change via call
  void informAlarmController() {
    // TODO implement
  }

  void resetDataModel() {
    singleData.value = ChartData(DateTime.now(), 0.0, 0);
    //clear historical data
    graphData.clear();
  }
}

// Construct a new data entry tuple
class ChartData {
  final DateTime time;
  final double value;
  final int counter;

  ChartData(this.time, this.value, this.counter);
}
