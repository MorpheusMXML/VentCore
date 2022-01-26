import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:uke_mlab/models/data_models/model_graph.dart';
import 'package:uke_mlab/models/data_models/model_graphdata.dart';
import 'package:uke_mlab/utilities/app_theme.dart';
import 'package:uke_mlab/utilities/enums/sensor.dart';

/// Creates an [SfCartesianChart] with two [NumericAxis] and an [AreaSeries].
///
/// The [sensor] parameter specifies the sensor this graph gets its data from. Typically, [sensorEnumGraph.co2] should be provided.
/// A corresponding [DataModelGraph] for the CPR Graph is created with [GetX].
class CO2Graph extends StatelessWidget {
  /// Creates a filled CO2 graph.
  final sensorEnumGraph sensor;

  /// Creates instance of [CO2Graph].
  const CO2Graph({
    Key? key,
    required this.sensor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    DataModelGraph dataModel = Get.find<DataModelGraph>(tag: sensor.name);

    return Obx(
      () => SfCartesianChart(
        backgroundColor: theme.primarySwatch[70],
        primaryYAxis: NumericAxis(
          majorGridLines: MajorGridLines(
            width: 1,
            color: theme.primarySwatch[40],
          ),
        ),
        primaryXAxis: NumericAxis(
          majorGridLines: MajorGridLines(
            width: 1,
            color: theme.primarySwatch[40],
          ),
        ),
        series: [
          // An AreaSeries renders a graph that is filled out with the specified color
          AreaSeries(
              color: dataModel.color,
              // DO NOT DELETE .value, SyncFusion charts would break in combination with GetX.
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
