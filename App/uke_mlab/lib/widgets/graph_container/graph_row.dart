import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:uke_mlab/utilities/enums/sensor.dart';

import 'package:uke_mlab/widgets/graph/graph.dart';
import 'package:uke_mlab/widgets/value_box/value_box_tile.dart';
import 'package:uke_mlab/widgets/graph/history_graph.dart';

class GraphRow extends StatelessWidget {
  /// renders the actual [Graph] for instance [HistoryGraph] and the [ValueBoxTile]
  final sensorEnumGraph sensor;
  const GraphRow({
    Key? key,
    required this.sensor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: solve special case via constructor (different enumType)
    /*if (sensor == sensorEnum.nibd) {
      return ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 150),
        child: Row(
          children: [
            Expanded(
              child: HistoryGraph(graphData: {
                'data': [
                  NIBDdata(DateTime.utc(2021, 12, 9, 11, 00), 120, 80),
                  NIBDdata(DateTime.utc(2021, 12, 9, 11, 05), 140, 95),
                  NIBDdata(DateTime.utc(2021, 12, 9, 11, 10), 180, 100),
                  NIBDdata(DateTime.utc(2021, 12, 9, 11, 15), 185, 75),
                  NIBDdata(DateTime.utc(2021, 12, 9, 11, 20), 200, 110),
                ].obs,
                'color': Colors.red,
              }),
            ),
            const SizedBox(width: 8),
            ValueBoxTile(sensor: sensor),
          ],
        ),
      );
    } else {
    */
    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 150),
      child: Row(
          children: (sensor == sensorEnumGraph.nibd)
              ? [
                  Expanded(child: HistoryGraph(sensor: sensor)),
                ]
              : [
                  Expanded(child: Graph(sensor: sensor)),
                  const SizedBox(width: 8),
                  evaluateValueBoxTile()
                ]),
    );
  }

//}
  Widget evaluateValueBoxTile() {
    if (SensorMapping.sensorMap[sensor] == null) {
      return ValueBoxTile.withoutAbsolute(sensorGraph: sensor);
    } else {
      return ValueBoxTile(
          sensorAbsolute:
              SensorMapping.sensorMap[sensor] as sensorEnumAbsolute);
    }
  }
}
