import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:uke_mlab/models/system_state.dart';
import 'package:uke_mlab/utilities/enums/alarm_priority.dart';
import 'package:uke_mlab/utilities/enums/sensor.dart';

import 'package:uke_mlab/widgets/graph_container/alarm_confirm_button.dart';
import 'package:uke_mlab/widgets/graph_container/graph_alarm_message.dart';

class GraphAlarmBorder extends StatelessWidget {
  /// Sets an border which is triggered through the [SystemState]
  ///
  /// Uses a Switch case to divide different alarmTypes read through [boundaryStateEnum]
  final sensorEnumAbsolute sensor;
  const GraphAlarmBorder({
    Key? key,
    required this.sensor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SystemState systemState = Get.find<SystemState>();
    return Obx(() {
      ///evaluate alarmTypes and see which Boundary is violated
      alarmPriority? alarm = systemState.alarmState[sensor]!["alarmPriorityEnum"];
      switch (alarm) {
        case alarmPriority.high:
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
        case alarmPriority.middle:
          return Column(
            children: [
              Expanded(
                child: Container(
                  color: Colors.yellow,
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
        case alarmPriority.confirmed:
          return Column(
            children: [
              Expanded(
                child: Container(
                  color: Colors.blue,
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
