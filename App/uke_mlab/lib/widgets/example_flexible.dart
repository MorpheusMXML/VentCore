import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:uke_mlab/widgets/value_box.dart';

class ExampleFlexible extends StatelessWidget {
  const ExampleFlexible({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      child: Row(
        children: [
          Flexible(
            flex: 3,
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
          ),
          Flexible(
            flex: 1,
            child: ValueBox(
              value: 20,
              textColor: 0xff0CECDD,
              backgroundColor: 0xff2A2831,
            ),
          )
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
