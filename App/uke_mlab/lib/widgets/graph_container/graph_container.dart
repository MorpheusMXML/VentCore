import 'package:flutter/material.dart';

import 'package:uke_mlab/utilities/enums/sensor.dart';

import 'package:uke_mlab/widgets/graph_container/graph_alarm_border.dart';
import 'package:uke_mlab/widgets/graph_container/graph_row.dart';

class GraphContainer extends StatelessWidget {
  /// Provides a frame for everything relating to graphs.
  ///
  /// Includes standard sizes i.e. [ConstrainedBox] as a Container
  /// Uses a Stack to divide [GraphAlarmBorder] and the [GraphRow]
  final sensorEnum sensor;

  const GraphContainer({
    Key? key,
    required this.sensor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 200),
      child: Stack(
        children: [
          GraphAlarmBorder(
            sensor: sensor,
          ),
          Container(
            margin: const EdgeInsets.only(top: 10.0),
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: GraphRow(
              sensor: sensor,
            ),
          ),
        ],
      ),
    );
  }
}
