import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:uke_mlab/models/data_models/model_graph.dart';
import 'package:uke_mlab/models/data_models/model_graphdata.dart';
import 'package:uke_mlab/utilities/app_theme.dart';
import 'package:uke_mlab/utilities/enums/sensor.dart';

// TODO: COMMENTARY
class RegularGraph extends StatelessWidget {
  final sensorEnumGraph sensor;
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
