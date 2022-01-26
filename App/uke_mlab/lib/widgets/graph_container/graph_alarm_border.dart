import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:uke_mlab/models/system_state.dart';
import 'package:uke_mlab/utilities/enums/alarm_status.dart';
import 'package:uke_mlab/utilities/enums/sensor.dart';

import 'package:uke_mlab/widgets/graph_container/alarm_confirm_button.dart';
import 'package:uke_mlab/widgets/graph_container/graph_alarm_message.dart';
import 'package:uke_mlab/widgets/graph_container/smart_adjustment_button.dart';

/// Creates a border behind a graph to indicate whether the graph is in an alarm state or not.
/// For that, different colors are used. Triggering alarm borders happens through the [SystemState].
class GraphAlarmBorder extends StatelessWidget {
  /// Border of a graph, the color depends on the [alarmStatus].
  final sensorEnumAbsolute sensor;

  /// Creates instance of [GraphAlarmBorder].
  const GraphAlarmBorder({
    Key? key,
    required this.sensor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SystemState systemState = Get.find<SystemState>();

    return Obx(() {
      // evaluate alarmTypes and see which boundary is violated
      alarmStatus? alarm = systemState.getAlarmStateStatus(sensor);
      switch (alarm) {
        case alarmStatus.high:
        case alarmStatus.middle:
        case alarmStatus.warning:
          return Column(
            children: [
              Expanded(
                child: Container(
                  color: systemState.getAlarmStateColor(sensor),
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Spacer(flex: 2),
                      AlarmConfirmButton(sensorKey: sensor),
                      const Spacer(flex: 2),
                      GraphAlarmMessage(sensorKey: sensor),
                      const Spacer(flex: 8),
                      SmartAdjustButton(sensorKey: sensor),
                      const Spacer(flex: 2),
                    ],
                  ),
                ),
              ),
            ],
          );
        case alarmStatus.confirmed:
          return Column(
            children: [
              Expanded(
                child: Container(
                  color:
                      systemState.getAlarmStateColor(sensor).withOpacity(0.65),
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
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
