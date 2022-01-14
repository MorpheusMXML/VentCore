import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';
import 'package:uke_mlab/models/model_nibd.dart';

///Creates a [SfCartesianChart] to Display a History Graph. Example Use: NIBD History
///
///Needs to be Instanciated with a [Map<String,Object?>] for the Graph data that should be Displayed.
///The Data [Object] of this Map should be of Type [NIBDdata] for a NIBD History for Example.
///
///Uses [findMax] to Find the Maximum in the Data to Configure the Scaling of the Graph.
///
///Uses a [ScatterSeries] to Plot the MAD Value of the BloodPressure Measurement
///Uses [HiloSeries] to Plot the Systolic and Diastolic Pressure as Hi and Low of the Series.
///
class HistoryGraph extends StatelessWidget {
  ///Returns the Widget for a History Graph. Taking a [Map<String, Object?>] to plot the corresponding Data Points.
  ///[Object?] can be of Type [NIBDdata] for example.
  final Map<String, Object?> graphData;

  const HistoryGraph({
    Key? key,
    required this.graphData,
  }) : super(key: key);

  /// Efficient way to find min and Max of the Y-Axis Interval that should be Rendered in [HistoryGraph] given the data in [graphData].
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
        majorGridLines: MajorGridLines(width: 0, color: Theme.of(context).shadowColor),
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
            Trendline(dashArray: <double>[2, 3], type: TrendlineType.movingAverage, color: Colors.redAccent)
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
          markerSettings: const MarkerSettings(shape: DataMarkerType.horizontalLine, width: 10, isVisible: true),
        ),
      ],
    );
  }
}
