import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:uke_mlab/models/enums.dart';
import 'package:uke_mlab/models/system_state.dart';

import 'package:uke_mlab/widgets/graph_container/alarm_confirm_button.dart';
import 'package:uke_mlab/widgets/graph_container/graph_alarm_message.dart';

class GraphAlarmBorder extends StatelessWidget {
  /// Sets an border which is triggered through the [SystemState]
  ///
  /// Uses a Switch case to divide different alarmTypes read through [boundaryStateEnum]
  final sensorEnum sensor;
  const GraphAlarmBorder({
    Key? key,
    required this.sensor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SystemState systemState = Get.find<SystemState>();
    return Obx(() {
      ///evaluate alarmTypes and see which Boundary is violated 
      boundaryStateEnum? alarmType = systemState.violationStates[sensor];
      switch (alarmType) {
        case boundaryStateEnum.lowerBoundaryViolated:
          return Column(
            children: [
              Expanded(
                child: Container(
                  color: Colors.red,
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      AlarmConfirmButton(sensor: sensor),
                      GraphAlarmMessage(sensor: sensor),
                    ],
                  ),
                ),
              ),
            ],
          );
        case boundaryStateEnum.upperBoundaryViolated:
          return Column(
            children: [
              Expanded(
                child: Container(
                  color: Colors.red,
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      AlarmConfirmButton(sensor: sensor),
                      GraphAlarmMessage(sensor: sensor),
                    ],
                  ),
                ),
              ),
            ],
          );
        case boundaryStateEnum.suppressed:
          return Column(
            children: [
              Expanded(
                child: Container(
                  color: Colors.red,
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 30),
                ),
              ),
            ],
          );
        default:
          return Container(
            margin: const EdgeInsets.only(bottom: 0),
          );
      }
    });
  }
}
