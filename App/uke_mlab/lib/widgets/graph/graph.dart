import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:uke_mlab/providers/mockup.dart';

class Graph extends StatelessWidget {
  final List<ChartData> data;
  final Color color;
  final String type;

  const Graph({
    Key? key,
    required this.data,
    required this.type,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final monitorController = Get.find<MonitorController>();
    ChartSeriesController? myController;

    // execute every 1000 milliseconds
    Timer.periodic(const Duration(milliseconds: 1000), (timer) {
      myController?.updateDataSource(
        addedDataIndexes: <int>[data.length - 1],
        removedDataIndexes: <int>[0],
      );
      monitorController.updateData(type);
    });

    return SfCartesianChart(
      backgroundColor: Theme.of(context).cardColor,
      primaryYAxis: NumericAxis(
        minimum: 0,
        maximum: 100,
        majorGridLines:
            MajorGridLines(width: 1, color: Theme.of(context).shadowColor),
      ),
      primaryXAxis: NumericAxis(
        majorGridLines: MajorGridLines(
            width: 1,
            color:
                Theme.of(context).shadowColor //Theme.of(context).shadowColor,
            ),
      ),
      series: [
        SplineSeries(
            color: color,
            dataSource: data,
            onRendererCreated: (ChartSeriesController controller) {
              myController = controller;
            },
            xValueMapper: (ChartData data, _) => data.counter,
            yValueMapper: (ChartData data, _) => data.value)
      ],
    );
  }
}
