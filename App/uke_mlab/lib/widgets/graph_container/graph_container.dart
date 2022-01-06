import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/utilities/enums/sensor.dart';
import 'package:uke_mlab/utilities/enums/boundary_state.dart';
import 'package:uke_mlab/models/model.dart';
import 'package:uke_mlab/models/system_state.dart';
import 'package:uke_mlab/widgets/graph/history_graph.dart';
import 'package:uke_mlab/widgets/graph_container/alarm_confirm_button.dart';
import 'package:uke_mlab/widgets/graph_container/graph_alarm_message.dart';
import 'package:uke_mlab/widgets/graph/graph.dart';
import 'package:uke_mlab/widgets/value_box/value_box_tile.dart';

class GraphContainer extends StatelessWidget {
  final sensorEnum sensor;

  const GraphContainer({
    Key? key,
    required this.sensor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SystemState systemState = Get.find<SystemState>();

    return Obx(() {
      boundaryStateEnum? alarmType = systemState.violationStates[sensor];

      switch (alarmType) {
        case boundaryStateEnum.lowerBoundaryViolated:
          return Container(
            color: Colors.red,
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 24),
            child: Column(
              children: [
                ConstrainedBox(
                  constraints: const BoxConstraints(maxHeight: 150),
                  child: Row(
                    children: [
                      AlarmConfirmButton(sensor: sensor),
                      const SizedBox(width: 8),
                      ...getGraphRow(),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                GraphAlarmMessage(sensor: sensor),
              ],
            ),
          );
        case boundaryStateEnum.upperBoundaryViolated:
          return Container(
            color: Colors.red,
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 24),
            child: Column(
              children: [
                ConstrainedBox(
                  constraints: const BoxConstraints(maxHeight: 150),
                  child: Row(
                    children: [
                      AlarmConfirmButton(sensor: sensor),
                      const SizedBox(width: 8),
                      ...getGraphRow(),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                GraphAlarmMessage(sensor: sensor),
              ],
            ),
          );
        case boundaryStateEnum.suppressed:
          return Container(
            color: Colors.red,
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.only(bottom: 8),
            child: ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 150),
                child: Row(
                  children: getGraphRow(),
                )),
          );
        default:
          return Container(
            margin: const EdgeInsets.only(bottom: 8),
            child: ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 150),
                child: Row(
                  children: getGraphRow(),
                )),
          );
      }
    });
  }

  List<Widget> getGraphRow() {
    List<Widget> graphRow = [];

    if (sensor == sensorEnum.nibd) {
      // TODO: more or less hardcoded here
      graphRow.add(Expanded(
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
      ));
    } else {
      graphRow.add(Expanded(child: Graph(sensor: sensor)));
      graphRow.add(const SizedBox(width: 8));
      graphRow.add(ValueBoxTile(sensor: sensor));
    }

    return graphRow;
  }
}
