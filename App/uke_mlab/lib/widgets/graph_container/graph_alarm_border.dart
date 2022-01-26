import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:uke_mlab/models/system_state.dart';
import 'package:uke_mlab/utilities/enums/alarm_status.dart';
import 'package:uke_mlab/utilities/enums/sensor.dart';

import 'package:uke_mlab/widgets/graph_container/alarm_confirm_button.dart';
import 'package:uke_mlab/widgets/graph_container/graph_alarm_message.dart';
import 'package:uke_mlab/widgets/graph_container/smart_adjustment_button.dart';

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
                      SmartAjdustButton(sensorKey: sensor),
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
