import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:uke_mlab/providers/mockup.dart';

class Graph extends StatelessWidget {
  final List<ChartData> data;

  const Graph({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final monitorController = Get.find<MonitorController>();
    ChartSeriesController? myController;

    return Row(
      children: [
        Flexible(
          flex: 1,
          child: ElevatedButton(
            onPressed: () {
              myController?.updateDataSource(
                addedDataIndexes: <int>[data.length - 1],
                removedDataIndexes: <int>[0],
              );
              monitorController.updateData();
            },
            child: const Text("update"),
          ),
        ),
        Flexible(
          flex: 4,
          child: SfCartesianChart(
            primaryXAxis: CategoryAxis(),
            series: [
              LineSeries(
                  dataSource: data,
                  onRendererCreated: (ChartSeriesController controller) {
                    myController = controller;
                  },
                  xValueMapper: (ChartData data, _) => data.time,
                  yValueMapper: (ChartData data, _) => data.value)
            ],
          ),
        ),
      ],
    );
  }
}
