import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/models/model_graphdata.dart';
import 'package:uke_mlab/utilities/enums/sensor.dart';

class DataModelNIBD extends GetxController {
  final sensorEnumGraph sensorKey;

  String graphTitle = "No default title";
  String yAxisTitle = "No default yAxisTitle";
  String xAxisTitle = "No default xAxisTitle";
  Color color = Colors.white;

  late final Rx<ChartData> singleData;
  final RxList<ChartData> graphData = <ChartData>[].obs;
  int graphDataMaxLength = 1500;

  final RxList<List<int>> historicValues = <List<int>>[].obs;

  DataModelNIBD({required this.sensorKey}) {
    singleData =
        ChartData.asNIBD(counter: 0, time: DateTime.now(), value: <int>[0, 0])
            .obs;
  }

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
    // update only added/removed indexes instead of the whole chart (efficient)
    // chartController?.updateDataSource(updatedDataIndexes: [for (int i = 0; i < graphData.length; i++) i]);

    // TODO make "little" analysis here and call inform alarmManager to start evaluation
  }

  void resetDataModel() {
    singleData.value =
        ChartData.asNIBD(time: DateTime.now(), value: <int>[0, 0], counter: 0);
    //clear historical data
    graphData.clear();
  }

  void setGraphMaxLength(int newLength) {
    graphDataMaxLength = newLength;
    graphData.clear();
  }
}
