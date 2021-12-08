import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

import 'package:uke_mlab/providers/mockup.dart';

class HistoryGraph extends StatelessWidget {
  final Color color;
  final List<NIBDdata> data;

  const HistoryGraph({
    Key? key,
    required this.color,
    required this.data,
  }) : super(key: key);

  // More efficient... but Ugly lol
  double findMax(bool max) {
    if (max) {
      List<int> syst = [];
      data.forEach((element) {
        syst.add(element.systolicPressure);
      });
      syst.sort();

      return syst.last.toDouble();
    } else {
      List<int> dist = [];

      data.forEach((element) {
        dist.add(element.diastolicPressure);
      });

      dist.sort();
      return dist.first.toDouble();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
        tooltipBehavior: TooltipBehavior(enable: true),
        backgroundColor: Theme.of(context).cardColor,
        primaryYAxis: NumericAxis(
          desiredIntervals: 10,
          maximum: (findMax(true) + 5),
          minimum: (findMax(false) - 5),
          majorGridLines: MajorGridLines(
              width: 1,
              color: Theme.of(context).shadowColor,
              dashArray: const <double>[2, 3]),
        ),
        primaryXAxis: DateTimeAxis(
          dateFormat: DateFormat.Hm(),
          plotOffset: 10,
          desiredIntervals: 25,
          majorGridLines: MajorGridLines(
              width: 0,
              color:
                  Theme.of(context).shadowColor //Theme.of(context).shadowColor,
              ),
        ),
        series: [
          // Renders scatter chart
          ScatterSeries(
            markerSettings: const MarkerSettings(
                height: 10,
                width: 10,
                // Scatter will render in diamond shape
                shape: DataMarkerType.diamond),
            trendlines: <Trendline>[
              Trendline(
                  dashArray: <double>[2, 3],
                  type: TrendlineType.movingAverage,
                  color: Colors.redAccent)
            ],
            color: color,
            dataSource: data,
            xValueMapper: (NIBDdata data, _) => data.timestamp,
            yValueMapper: (NIBDdata data, _) => data.mad,
          ),
          HiloSeries(
              enableTooltip: true,
              dataSource: data,
              color: Colors.red,
              xValueMapper: (NIBDdata data, _) => data.timestamp,
              lowValueMapper: (NIBDdata data, _) => data.diastolicPressure,
              highValueMapper: (NIBDdata data, _) => data.systolicPressure,
              markerSettings: const MarkerSettings(
                  shape: DataMarkerType.horizontalLine,
                  width: 10,
                  isVisible: true)),
        ]);
  }
}
