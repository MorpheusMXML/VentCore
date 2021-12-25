import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/models/enums.dart';
import 'package:uke_mlab/models/model.dart';
import 'package:uke_mlab/widgets/graph/history_graph.dart';
import 'package:uke_mlab/widgets/graph_container/alarm_container.dart';
import 'package:uke_mlab/widgets/value_box/value_box.dart';
import 'package:uke_mlab/widgets/graph/graph.dart';

class GraphContainer extends StatelessWidget {
  final sensorEnum sensor;

  const GraphContainer({
    Key? key,
    required this.sensor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> graphrow = [];

    if (sensor == sensorEnum.nibd) {
      // TODO: more or less hardcoded here
      graphrow.add(Expanded(
        child: HistoryGraph(graphData: {
          "type": const {
            "abbr": "NIBD",
            "id": "NIBD",
            "index": 4,
          },
          "data": [
            NIBDdata(DateTime.utc(2021, 12, 9, 11, 00), 120, 80),
            NIBDdata(DateTime.utc(2021, 12, 9, 11, 05), 140, 95),
            NIBDdata(DateTime.utc(2021, 12, 9, 11, 10), 180, 100),
            NIBDdata(DateTime.utc(2021, 12, 9, 11, 15), 185, 75),
            NIBDdata(DateTime.utc(2021, 12, 9, 11, 20), 200, 110),
          ].obs,
          "color": Colors.red,
          "count": 0,
          "alarm": "none".obs,
          "visible": false.obs,
          "muted": false.obs,
        }),
      ));
    } else {
      graphrow.add(Expanded(child: Graph(sensor: sensor)));
      graphrow.add(Container(width: 8));
      graphrow.add(ValueBox(sensor: sensor));
    }

    return AlarmContainer(graphContainer: Row(children: graphrow));
  }
}
