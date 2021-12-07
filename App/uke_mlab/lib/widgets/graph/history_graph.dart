import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

import 'package:uke_mlab/providers/mockup.dart';

class HistoryGraph extends StatelessWidget {
  final Color color;
  final String type;
  final List<NIBDdata> data;

  const HistoryGraph({
    Key? key,
    required this.type,
    required this.color,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
        backgroundColor: Theme.of(context).cardColor,
        primaryYAxis: NumericAxis(
          desiredIntervals: 10,
          maximum: 145,
          minimum: 55,
          majorGridLines: MajorGridLines(width: 1, color: Theme.of(context).shadowColor),
        ),
        primaryXAxis: DateTimeAxis(
          dateFormat: DateFormat.Hm(),
          plotOffset: 10,
          desiredIntervals: 25,
          majorGridLines: MajorGridLines(width: 1, color: Theme.of(context).shadowColor //Theme.of(context).shadowColor,
              ),
        ),
        series: [
          // Renders scatter chart
          ScatterSeries(
            markerSettings: const MarkerSettings(
                height: 10,
                width: 10,
                // Scatter will render in diamond shape
                shape: DataMarkerType.circle),
            color: color,
            dataSource: data,
            xValueMapper: (NIBDdata data, _) => data.timestamp,
            yValueMapper: (NIBDdata data, _) => data.mad,
          ),
          ErrorBarSeries(
            dataSource: data,
            xValueMapper: (NIBDdata data, _) => data.timestamp,
            yValueMapper: (NIBDdata data, _) => data.mad,
            type: ErrorBarType.custom,
            verticalPositiveErrorValue: data[0].systolicPressure.toDouble(),
          )
          /*   HiloSeries(
            dataSource: data,
            color: Colors.green,
            xValueMapper: (NIBDdata data, _) => data.timestamp,
            lowValueMapper: (NIBDdata data, _) => data.diastolicPressure,
            highValueMapper: (NIBDdata data, _) => data.systolicPressure,
          ) */
        ]);
  }
}
