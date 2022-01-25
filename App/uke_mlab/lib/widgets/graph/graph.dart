import 'package:flutter/material.dart';
import 'package:uke_mlab/utilities/enums/sensor.dart';
import 'package:uke_mlab/widgets/graph/cpr_graph.dart';
import 'package:uke_mlab/widgets/graph/history_graph.dart';
import 'package:uke_mlab/widgets/graph/regular_graph.dart';

// TODO: COMMENTARY
class Graph extends StatelessWidget {
  final sensorEnumGraph sensor;

  const Graph({
    Key? key,
    required this.sensor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (sensor) {
      case sensorEnumGraph.cpr:
        return CprGraph(sensor: sensor);
      case sensorEnumGraph.nibd:
        return HistoryGraph(sensor: sensor);
      // case sensorEnumGraph.co2:
      //   return Co2Graph(sensor: sensor);
      default:
        return RegularGraph(sensor: sensor);
    }
  }
}
