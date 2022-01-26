import 'package:flutter/material.dart';

import 'package:uke_mlab/utilities/enums/sensor.dart';
import 'package:uke_mlab/widgets/graph/co2_graph.dart';
import 'package:uke_mlab/widgets/graph/cpr_graph.dart';

import 'package:uke_mlab/widgets/graph/regular_graph.dart';
import 'package:uke_mlab/widgets/value_box/value_box_tile.dart';
import 'package:uke_mlab/widgets/graph/history_graph.dart';

/// Renders the row consisting of a graph ([CprGraph], [HistoryGraph], [CO2Graph] and [RegularGraph]) and a [ValueBoxTile] (optional).
///
/// Uses:
/// + [CprGraph]
/// + [HistoryGraph]
/// + [CO2Graph]
/// + [RegularGraph]
/// + [ValueBoxTile]
///
/// {@category Widgets}
/// {@subCategory Graph Container}
class GraphRow extends StatelessWidget {
  /// Key to identify the corresponding sensor
  final sensorEnumGraph sensor;
  
  const GraphRow({
    Key? key,
    required this.sensor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 150),
      child: Row(children: [
        Expanded(
          child: evaluateGraph(),
        ),
        if (sensor != sensorEnumGraph.nibd)
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: evaluateValueBoxTile(),
          )
      ]),
    );
  }

  /// Evaluates what type of [ValueBoxTile] will be shown. The decision depends on the provided sensor.
  ValueBoxTile evaluateValueBoxTile() {
    return SensorMapping.sensorMap[sensor] == null
        ? ValueBoxTile.withoutAbsolute(sensorGraph: sensor)
        : ValueBoxTile(sensorAbsolute: SensorMapping.sensorMap[sensor]);
  }

  /// Evaluates what type of graph will be shown. The decision depends on the provided sensor.
  /// [sensorEnumGraph.cpr] is should use the [CprGraph].
  /// [sensorEnumGraph.nibd] is should use the [HistoryGraph].
  /// [sensorEnumGraph.co2] is should use the [CO2Graph].
  /// Every other instance of [sensorEnumGraph] should use the [RegularGraph].
  Widget evaluateGraph() {
    switch (sensor) {
      case sensorEnumGraph.cpr:
        return CprGraph(sensor: sensor);
      case sensorEnumGraph.nibd:
        return HistoryGraph(sensor: sensor);
      case sensorEnumGraph.co2:
        return CO2Graph(sensor: sensor);
      default:
        return RegularGraph(sensor: sensor);
    }
  }
}
