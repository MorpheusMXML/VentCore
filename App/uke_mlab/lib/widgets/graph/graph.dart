import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:uke_mlab/models/enums.dart';
import 'package:uke_mlab/models/model.dart';

class Graph extends StatelessWidget {
  final sensorEnum sensor;

  const Graph({
    Key? key,
    required this.sensor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DataModel dataModel = Get.find<DataModel>(tag: sensor.toString());
    return Obx(
      () => SfCartesianChart(
        backgroundColor: Theme.of(context).cardColor,
        primaryYAxis: NumericAxis(
          majorGridLines:
              MajorGridLines(width: 1, color: Theme.of(context).shadowColor),
        ),
        primaryXAxis: NumericAxis(
          majorGridLines:
              MajorGridLines(width: 1, color: Theme.of(context).shadowColor),
        ),
        series: [
          SplineSeries(
              color: dataModel.color,
              dataSource: dataModel.graphData.value,
              onRendererCreated: (ChartSeriesController controller) {
                dataModel.chartController = controller;
              },
              xValueMapper: (ChartData data, _) => data.counter,
              yValueMapper: (ChartData data, _) => data.value)
        ],
      ),
    );
  }
}
