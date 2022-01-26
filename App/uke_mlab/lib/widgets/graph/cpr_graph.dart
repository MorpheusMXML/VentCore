import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:uke_mlab/models/data_models/model_graph.dart';
import 'package:uke_mlab/utilities/app_theme.dart';
import 'package:uke_mlab/utilities/enums/sensor.dart';
import 'package:uke_mlab/models/data_models/model_graphdata.dart';

/// Creates an [SfCartesianChart] with two [NumericAxis], two [PlotBand]s and a [ColumnSeries].
/// The Graph rendered displays a history of how well the CPR has been performed in relation to the compression depth.
///
/// The [sensor] parameter specifies the sensor this graph gets its data from. Typically, [sensorEnumGraph.cpr] should be provided.
/// A correspondig [DataModelGraph] for the CPR Graph is created with [GetX].
///
/// {@category Graph}
class CprGraph extends StatelessWidget {
  /// Creates a CPR bar graph to indicate optimum pressure applied during CPR.
  final sensorEnumGraph sensor;

  /// Creates instance of the CPR bar graph
  const CprGraph({
    Key? key,
    required this.sensor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    DataModelGraph dataModel = Get.find<DataModelGraph>(tag: sensor.name);

    return Obx(
      () => SfCartesianChart(
        tooltipBehavior: TooltipBehavior(enable: true),
        backgroundColor: theme.primarySwatch[40],
        primaryYAxis: NumericAxis(
          // This disables String labels at x-axis
          labelStyle: const TextStyle(fontSize: 0.0001),

          // PlotBands create the green horizontal line to indicate the optimum depth interval.
          plotBands: <PlotBand>[
            PlotBand(
              isVisible: true,
              start: 5,
              end: 5,
              borderWidth: 1,
              borderColor: Colors.green,
            ),
            PlotBand(
              isVisible: true,
              start: 6,
              end: 6,
              borderWidth: 1,
              borderColor: Colors.green,
            )
          ],
          isInversed: true,
          maximum: 9.5,
          minimum: 2,
          majorGridLines: MajorGridLines(
            width: 1,
            color: theme.primarySwatch[20],
          ),
        ),
        primaryXAxis: NumericAxis(
          // This disables String labels at x-axis
          labelStyle: const TextStyle(fontSize: 0.0001),
          desiredIntervals: 25,
          majorGridLines: MajorGridLines(
            width: 1,
            color: theme.primarySwatch[20],
          ),
        ),
        series: <ColumnSeries<ChartData, dynamic>>[
          ColumnSeries<ChartData, dynamic>(
              // DO NOT DELETE .value, SyncFusion charts would break in combination with GetX.
              // ignore: invalid_use_of_protected_member
              dataSource: dataModel.graphData.value,
              onRendererCreated: (ChartSeriesController controller) {
                dataModel.chartController = controller;
              },
              yValueMapper: (ChartData graphData, _) => graphData.value,
              xValueMapper: (ChartData graphData, _) => graphData.counter,
              pointColorMapper: (ChartData graphData, _) => graphData.color)
        ],
      ),
    );
  }
}
