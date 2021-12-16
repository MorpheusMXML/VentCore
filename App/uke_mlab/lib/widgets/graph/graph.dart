import 'dart:math';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:uke_mlab/providers/mockup.dart';

class Graph extends StatelessWidget {
  final Map<String, Object?> graphData;

  const Graph({
    Key? key,
    required this.graphData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
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
            color: graphData["color"] as Color,
            dataSource: graphData["data"] as List<ChartDataMockup>,
            onRendererCreated: (ChartSeriesController controller) {
              graphData["controller"] = controller;
            },
            xValueMapper: (ChartDataMockup data, _) => data.counter,
            yValueMapper: (ChartDataMockup data, _) => data.value)
      ],
    );
  }
}
