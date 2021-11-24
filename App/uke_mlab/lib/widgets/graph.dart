import 'dart:async';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Graph extends StatelessWidget {
  const Graph({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 30, bottom: 20),
      child: SfCartesianChart(
        // Initialize category axis
        primaryXAxis: CategoryAxis(),
        series: <ChartSeries>[
          // Initialize line series
          LineSeries<ChartData, String>(
              dataSource: [
                // Bind data source
                ChartData('Jan', 35),
                ChartData('Feb', 28),
                ChartData('Mar', 34),
                ChartData('Apr', 32),
                ChartData('May', 40)
              ],
              xValueMapper: (ChartData sales, _) => sales.time,
              yValueMapper: (ChartData sales, _) => sales.value)
        ],
      ),
    );
  }
}

class ChartData {
  ChartData(this.time, this.value);
  final String time;
  final double? value;
}
