import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';
import 'package:uke_mlab/models/model.dart';

class CprGraph extends StatelessWidget {
  const CprGraph({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<CPRData> graphData = [
      CPRData(DateTime.utc(2022, 01, 12, 12, 50), 6),
      CPRData(DateTime.utc(2022, 01, 12, 12, 51), 5),
      CPRData(DateTime.utc(2022, 01, 12, 12, 52), 4),
      CPRData(DateTime.utc(2022, 01, 12, 12, 53), 2),
      CPRData(DateTime.utc(2022, 01, 12, 12, 54), 4),
      CPRData(DateTime.utc(2022, 01, 12, 12, 55), 4),
      CPRData(DateTime.utc(2022, 01, 12, 12, 56), 5),
      CPRData(DateTime.utc(2022, 01, 12, 12, 57), 5),
      CPRData(DateTime.utc(2022, 01, 12, 12, 58), 5),
      CPRData(DateTime.utc(2022, 01, 12, 12, 59), 5),
      CPRData(DateTime.utc(2022, 01, 12, 13, 00), 5),
      CPRData(DateTime.utc(2022, 01, 12, 13, 1), 6),
      CPRData(DateTime.utc(2022, 01, 12, 13, 2), 6),
      CPRData(DateTime.utc(2022, 01, 12, 13, 3), 6),
      CPRData(DateTime.utc(2022, 01, 12, 13, 4), 8),
      CPRData(DateTime.utc(2022, 01, 12, 13, 5), 9),
      CPRData(DateTime.utc(2022, 01, 12, 13, 6), 7),
      CPRData(DateTime.utc(2022, 01, 12, 13, 7), 5),
      CPRData(DateTime.utc(2022, 01, 12, 13, 8), 5),
      CPRData(DateTime.utc(2022, 01, 12, 13, 9), 5),
      CPRData(DateTime.utc(2022, 01, 12, 13, 10), 4),
      CPRData(DateTime.utc(2022, 01, 12, 13, 11), 6),
      CPRData(DateTime.utc(2022, 01, 12, 13, 12), 7),
      CPRData(DateTime.utc(2022, 01, 12, 13, 13), 8),
      CPRData(DateTime.utc(2022, 01, 12, 13, 14), 5),
    ];

    return SfCartesianChart(
      tooltipBehavior: TooltipBehavior(enable: true),
      backgroundColor: Theme.of(context).cardColor,
      primaryYAxis: NumericAxis(
        isInversed: true,
        maximum: 9.5,
        minimum: 2,
        majorGridLines: MajorGridLines(
          width: 1,
          color: Theme.of(context).shadowColor,
          dashArray: const <double>[2, 3],
        ),
      ),
      primaryXAxis: DateTimeAxis(
        dateFormat: DateFormat.Hm(),
        plotOffset: 10,
        desiredIntervals: 25,
        majorGridLines: MajorGridLines(width: 0, color: Theme.of(context).shadowColor),
      ),
      series: <ColumnSeries<CPRData, dynamic>>[
        ColumnSeries<CPRData, dynamic>(
          dataSource: graphData,
          yValueMapper: (CPRData graphData, _) => graphData.xvalue,
          xValueMapper: (CPRData graphData, _) => graphData.dateTime,
        )
      ],
    );
  }
}

class CPRData {
  final DateTime dateTime;
  final int xvalue;

  CPRData(this.dateTime, this.xvalue);
}
