import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/models/data_models/model_graphdata.dart';
import 'package:uke_mlab/utilities/enums/sensor.dart';
import 'package:uke_mlab/widgets/graph/history_graph.dart';

class DataModelNIBD extends GetxController {
  /// Represents the DataModel for systolic and diastolic blood pressure measurements. And holds the information for the [HistoryGraph].

  /// sensor key hinting at the corresponding sensor addressing the current [DataModelNIBD]
  final sensorEnumGraph sensorKey;

  /// title to be associated with the [DataModelNIBD]
  String graphTitle = "No default title";

  /// y-axis title to be associated with the [DataModelNIBD]
  String yAxisTitle = "No default yAxisTitle";

  /// x-axis title to be associated with the [DataModelNIBD]
  String xAxisTitle = "No default xAxisTitle";

  /// color to be associated with the [DataModelNIBD]
  Color color = Colors.white;

  /// representation of the latest data point in form of [ChartData]
  late final Rx<ChartData> singleData;

  /// representation of the data to be printed as a graph in form of a list over [ChartData] of the length [graphDataMaxLength]
  final RxList<ChartData> graphData = <ChartData>[].obs;

  /// max length of [graphData]
  int graphDataMaxLength = 1500;

  /// inits the [DataModelNIBD] with given [sensorKey]
  /// data is [ChartData.asNIBD]
  DataModelNIBD({required this.sensorKey}) {
    singleData =
        ChartData.asNIBD(counter: 0, time: DateTime.now(), value: <int>[0, 0])
            .obs;
  }

  /// Updates the [graphData] with all points from [valueList].
  void updateValues(List<dynamic> valueList) {
    for (int i = 0; i < valueList.length; i++) {
      singleData.value = ChartData.asNIBD(
          time: DateTime.now(),
          value: valueList[i],
          counter: singleData.value.counter + 1);
      graphData.add(singleData.value);
    }

    if (graphData.length + 1 > graphDataMaxLength) {
      for (var i = 0; i < valueList.length; i++) {
        graphData.removeAt(0);
      }
    }
  }

  /// Resets this [DataModelNIBD], clears the [graphData] and sets the [singleData] to zero.
  void resetDataModel() {
    singleData.value =
        ChartData.asNIBD(time: DateTime.now(), value: <int>[0, 0], counter: 0);
    //clear historical data
    graphData.clear();
  }

  /// This sets the [graphDataMaxLength] to the [newLength] and resets the [graphData].
  void setGraphMaxLength(int newLength) {
    graphDataMaxLength = newLength;
    graphData.clear();
  }
}
