import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:uke_mlab/providers/mockup.dart';

class Graph extends StatelessWidget {
  final List<ChartData> data;
  final Color color;

  const Graph({
    Key? key,
    required this.data,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final monitorController = Get.find<MonitorController>();
    ChartSeriesController? myController;

    // execute every 500 milliseconds
    Timer.periodic(const Duration(milliseconds: 500), (timer) {
      myController?.updateDataSource(
        addedDataIndexes: <int>[data.length - 1],
        removedDataIndexes: <int>[0],
      );
      monitorController.updateData();
    });

    return SfCartesianChart(
      primaryXAxis: CategoryAxis(),
      series: [
        SplineSeries(
            color: color,
            dataSource: data,
            onRendererCreated: (ChartSeriesController controller) {
              myController = controller;
            },
            xValueMapper: (ChartData data, _) => data.time,
            yValueMapper: (ChartData data, _) => data.value)
      ],
    );
  }
}
