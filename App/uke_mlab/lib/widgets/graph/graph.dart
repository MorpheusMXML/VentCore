import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:uke_mlab/models/enums.dart';
import 'package:uke_mlab/models/model.dart';
import 'package:uke_mlab/providers/mockup.dart';

class Graph extends StatelessWidget {
  late Map<String, Object?> graphData;
  late sensorEnum sensor;
  ChartSeriesController? chartController;

  late final bool withModel;

  Graph({
    Key? key,
    required this.graphData,
    this.withModel = false,
  }) : super(key: key);

  Graph.withModel({
    Key? key,
    required this.sensor,
    this.withModel = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (withModel) {
      DataModel dataModel = Get.find<DataModel>(tag: sensor.toString());
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
                dataSource: dataModel.graphData.value,
                onRendererCreated: (ChartSeriesController controller) {
                  chartController = controller;
                },
                xValueMapper: (ChartData data, _) => data.counter,
                yValueMapper: (ChartData data, _) => data.value)
          ],
        ),
      );
    } else {
      return SfCartesianChart(
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
              color: graphData["color"] as Color,
              dataSource: graphData["data"] as List<ChartDataMockup>,
              onRendererCreated: (ChartSeriesController controller) {
                graphData["controller"] = controller;
              },
              xValueMapper: (ChartDataMockup data, _) => data.counter,
              yValueMapper: (ChartDataMockup data, _) => data.value)
        ],
      );
    }
  }
}
