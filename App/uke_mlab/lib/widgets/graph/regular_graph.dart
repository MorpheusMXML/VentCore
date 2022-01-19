import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:uke_mlab/models/data_models/model_graph.dart';
import 'package:uke_mlab/models/data_models/model_graphdata.dart';
import 'package:uke_mlab/utilities/enums/sensor.dart';

class RegularGraph extends StatelessWidget {
  final sensorEnumGraph sensor;
  const RegularGraph({
    Key? key,
    required this.sensor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DataModelGraph dataModel = Get.find<DataModelGraph>(tag: sensor.name);

    return Obx(
      () => SfCartesianChart(
        backgroundColor: Theme.of(context).cardColor,
        primaryYAxis: NumericAxis(
          majorGridLines:
              MajorGridLines(width: 1, color: Theme.of(context).shadowColor),
        ),
        primaryXAxis: NumericAxis(
          majorGridLines:
              MajorGridLines(width: 1, color: Theme.of(context).shadowColor),
        ),
        series: [
          SplineSeries(
              color: dataModel.color,
              // DONT DELETE .value, syncfusion would break in combination wiht Getx
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
