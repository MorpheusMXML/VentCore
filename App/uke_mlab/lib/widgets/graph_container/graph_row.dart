import 'package:flutter/material.dart';

import 'package:uke_mlab/utilities/enums/sensor.dart';

import 'package:uke_mlab/widgets/graph/graph.dart';
import 'package:uke_mlab/widgets/value_box/value_box_tile.dart';
import 'package:uke_mlab/widgets/graph/history_graph.dart';

class GraphRow extends StatelessWidget {
  /// renders the actual [Graph] for instance [HistoryGraph] and the [ValueBoxTile]

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
          child: Graph(sensor: sensor),
        ),
        if (sensor != sensorEnumGraph.nibd) ...[
          const SizedBox(width: 8),
          evaluateValueBoxTile()
        ]
      ]),
    );
  }

  Widget evaluateValueBoxTile() {
    if (SensorMapping.sensorMap[sensor] == null) {
      return ValueBoxTile.withoutAbsolute(sensorGraph: sensor);
    } else {
      return ValueBoxTile(sensorAbsolute: SensorMapping.sensorMap[sensor]);
    }
  }
}
