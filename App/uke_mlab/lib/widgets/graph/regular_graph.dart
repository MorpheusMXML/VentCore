import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:uke_mlab/models/data_models/model_graph.dart';
import 'package:uke_mlab/models/data_models/model_graphdata.dart';
import 'package:uke_mlab/utilities/app_theme.dart';
import 'package:uke_mlab/utilities/enums/sensor.dart';

/// Creates an [SfCartesianChart] with two [NumericAxis] and a [SplineSeries].
/// This is the most commonly used graph type.
///
/// The [sensor] parameter specifies the sensor this graph gets its data from. Typically, [sensorEnumGraph.ecgCh1], [sensorEnumGraph.ecgCh2], [sensorEnumGraph.flow], [sensorEnumGraph.paw] or [sensorEnumGraph.pleth] should be provided.
/// A correspondig [DataModelGraph] for the CPR Graph is created with [GetX].
class RegularGraph extends StatelessWidget {
  /// Creates a regular graph.
  final sensorEnumGraph sensor;

  /// Creates instance [RegularGraph].
  const RegularGraph({
    Key? key,
    required this.sensor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    DataModelGraph dataModel = Get.find<DataModelGraph>(tag: sensor.name);

    return Obx(
      () => SfCartesianChart(
        backgroundColor: theme.primarySwatch[40],
        primaryYAxis: NumericAxis(
          majorGridLines: MajorGridLines(
            width: 1,
            color: theme.primarySwatch[20],
          ),
        ),
        primaryXAxis: NumericAxis(
          majorGridLines: MajorGridLines(
            width: 1,
            color: theme.primarySwatch[20],
          ),
        ),
        series: [
          SplineSeries(
              color: dataModel.color,
              // DONT DELETE .value, syncfusion would break in combination wiht Getx
              // ignore: invalid_use_of_protected_member
              dataSource: dataModel.graphData.value,
              onRendererCreated: (ChartSeriesController controller) {
                dataModel.chartController = controller;
              },
              xValueMapper: (ChartData data, _) => data.counter,
              yValueMapper: (ChartData data, _) => data.value)
        ],
      ),
    );
  }
}
