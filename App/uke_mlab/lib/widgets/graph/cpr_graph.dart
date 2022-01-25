import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:uke_mlab/models/data_models/model_graph.dart';
import 'package:uke_mlab/utilities/enums/sensor.dart';
import 'package:uke_mlab/models/data_models/model_graphdata.dart';

///This Class returns a [Obx] which in turn consists of a [SfCartesianChart] with two [NumericAxis].
///The Graph rendered with this displays a history of how good the CPR has been performed in relation to the compression depth.
///
///The [sensorEnum] parameter specifies the Sensor this Graph gets it data from.
///Also a correspondig [DataModel] for the CPR Graph is created with [GetX].
class CprGraph extends StatelessWidget {
  /// Creates a CPR Bar Graph to Indicate optimum pressure applied during CPR.
  final sensorEnumGraph sensor;

  ///Creates Instance of the CPR Bar Graph
  const CprGraph({Key? key, required this.sensor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DataModelGraph dataModel = Get.find<DataModelGraph>(tag: sensor.name);

    return Obx(
      () => SfCartesianChart(
        tooltipBehavior: TooltipBehavior(enable: true),
        backgroundColor: Theme.of(context).cardColor,
        primaryYAxis: NumericAxis(
          //Turning off String Labels at the Axis
          labelStyle: const TextStyle(fontSize: 0.0001),

          ///PlotBands Create the green horizontal Line to Indicate the optimum depth Interval.
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
            color: Theme.of(context).shadowColor,
          ),
        ),
        primaryXAxis: NumericAxis(
          //Turning off String Labels at the Axis
          labelStyle: const TextStyle(fontSize: 0.0001),
          desiredIntervals: 25,
          majorGridLines: MajorGridLines(width: 1, color: Theme.of(context).shadowColor),
        ),
        series: <ColumnSeries<ChartData, dynamic>>[
          ColumnSeries<ChartData, dynamic>(
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
