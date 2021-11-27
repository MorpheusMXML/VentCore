import 'dart:async';
//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_core/firebase_core.dart';
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
    ChartSeriesController? _chartSeriesController;

    return Container(
      margin: const EdgeInsets.only(top: 30, bottom: 20),
      child: Row(
        children: [
          Flexible(
            flex: 1,
            child: ElevatedButton(
              onPressed: () {
                _chartSeriesController?.updateDataSource(
                  addedDataIndexes: <int>[data.length - 1],
                  removedDataIndexes: <int>[0],
                );
                monitorController.updateData();
              },
              child: Text("update"),
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
                      _chartSeriesController = controller;
                    },
                    xValueMapper: (ChartData data, _) => data.time,
                    yValueMapper: (ChartData data, _) => data.value)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
