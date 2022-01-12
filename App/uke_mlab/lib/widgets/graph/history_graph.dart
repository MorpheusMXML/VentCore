import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';
import 'package:uke_mlab/models/model_nibd.dart';

class HistoryGraph extends StatelessWidget {
  final Map<String, Object?> graphData;

  const HistoryGraph({
    Key? key,
    required this.graphData,
  }) : super(key: key);

  // More efficient... but Ugly lol
  double findMax(bool max) {
    if (max) {
      List<int> syst = [];
      for (var element in (graphData['data'] as List<NIBDdata>)) {
        syst.add(element.systolicPressure);
      }
      syst.sort();

      return syst.last.toDouble();
    } else {
      List<int> dist = [];

      for (var element in (graphData['data'] as List<NIBDdata>)) {
        dist.add(element.diastolicPressure);
      }

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
          dashArray: const <double>[2, 3],
        ),
      ),
      primaryXAxis: DateTimeAxis(
        dateFormat: DateFormat.Hm(),
        plotOffset: 10,
        desiredIntervals: 25,
        majorGridLines:
            MajorGridLines(width: 0, color: Theme.of(context).shadowColor),
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
          color: graphData['color'] as Color,
          dataSource: graphData['data'] as List<NIBDdata>,
          xValueMapper: (NIBDdata data, _) => data.time,
          yValueMapper: (NIBDdata data, _) => data.mad,
        ),
        HiloSeries(
          enableTooltip: true,
          dataSource: graphData['data'] as List<NIBDdata>,
          color: Colors.red,
          xValueMapper: (NIBDdata data, _) => data.time,
          lowValueMapper: (NIBDdata data, _) => data.diastolicPressure,
          highValueMapper: (NIBDdata data, _) => data.systolicPressure,
          markerSettings: const MarkerSettings(
              shape: DataMarkerType.horizontalLine, width: 10, isVisible: true),
        ),
      ],
    );
  }
}
