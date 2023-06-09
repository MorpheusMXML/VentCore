import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:uke_mlab/providers/alarm_controller.dart';
import 'package:uke_mlab/utilities/enums/sensor.dart';
import 'package:uke_mlab/widgets/graph_container/graph_container.dart';
import 'model_graphdata.dart';

/// Represents the data model to be used in [GraphContainer] and sub widgets.
///
/// [graphData] includes the [singleData] value at the end
/// Alarm evaluation is done in [AlarmController]
/// [graphDataMaxLength] is initialized with 0, later manipulated via the sensors
///
/// {@category DataModels}
class DataModelGraph extends GetxController {
  /// sensor key hinting at the corresponding sensor addressing the current [DataModelGraph]
  final sensorEnumGraph sensorKey;

  /// title to be associated with the [DataModelGraph]
  String graphTitle = "No default title";

  /// y-axis title to be associated with the [DataModelGraph]
  String yAxisTitle = "No default yAxisTitle";

  /// x-axis title to be associated with the [DataModelGraph]
  String xAxisTitle = "No default xAxisTitle";

  /// color to be associated with the [DataModelGraph]
  Color color = Colors.white;

  /// [ChartSeriesController] associated with the [DataModelGraph], used in rendering the graphs
  ChartSeriesController? chartController;

  /// representation of the latest data point in form of [ChartData]
  late final Rx<ChartData> singleData;

  /// representation of the data to be printed as a graph in form of a list over [ChartData] of the length [graphDataMaxLength]
  final RxList<ChartData> graphData = <ChartData>[].obs;

  /// max length of [graphData]
  int graphDataMaxLength = 0;

  /// inits the [DataModelGraph] with given [sensorKey]
  /// data is either [ChartData] or [ChartData.asCPR] depending on [sensorKey]
  DataModelGraph({required this.sensorKey}) {
    switch (sensorKey) {
      case sensorEnumGraph.cpr:
        singleData = ChartData.asCPR(time: DateTime.now(), counter: 0, value: 0.0).obs;
        break;
      default:
        singleData = ChartData(time: DateTime.now(), counter: 0, value: 0.0).obs;
    }
  }

  /// updates [graphData] with given [valueList] with either [ChartData] or [ChartData.asCPR] depending on [sensorKey]
  ///
  /// if [graphData] exceeds [graphDataMaxLength] the oldest values will be pruned
  void updateValues(List<dynamic> valueList) {
    // Check wether Data loaded is from CPR Sensor. To Change Constructor Call for ChartData to ChartData.asCPR
    switch (sensorKey) {
      case sensorEnumGraph.cpr:
        for (int i = 0; i < valueList.length; i++) {
          singleData.value = ChartData.asCPR(
              time: DateTime.now(), value: valueList[i].toDouble(), counter: singleData.value.counter + 1);
          graphData.add(singleData.value);
        }

        if (graphData.length + 1 > graphDataMaxLength) {
          for (var i = 0; i < valueList.length; i++) {
            graphData.removeAt(0);
          }
        }

        if (chartController is ChartSeriesController && chartController != null) {
          chartController!.updateDataSource(updatedDataIndexes: List.generate(graphDataMaxLength, (index) => index++));
        }
        break;
      default:
        for (int i = 0; i < valueList.length; i++) {
          singleData.value =
              ChartData(time: DateTime.now(), value: valueList[i].toDouble(), counter: singleData.value.counter + 1);
          graphData.add(singleData.value);
        }

        if (graphData.length + 1 > graphDataMaxLength) {
          for (var i = 0; i < valueList.length; i++) {
            graphData.removeAt(0);
          }
        }
    }
  }

  /// generates an initial population of [graphData] of [graphDataMaxLength] length, representing a 0-line
  void populateGraphList() {
    for (int i = 0; i < graphDataMaxLength; i++) {
      singleData.value = ChartData(counter: i, time: DateTime.now(), value: 0.0);
      graphData.add(singleData.value);
    }
  }

  /// resets [graphData] and [singleData], repopulates [graphData] using [populateGraphList] afterwards
  void resetDataModel() {
    singleData.value = ChartData(time: DateTime.now(), value: 0.0, counter: 0);
    //clear historical data
    graphData.clear();
    populateGraphList();
  }

  /// sets [graphDataMaxLength], clears and repopulates [graphData] using [populateGraphList] afterwards to reflect new size
  void setGraphMaxLength(int newLength) {
    graphDataMaxLength = newLength;
    graphData.clear();
    populateGraphList();
  }
}
