import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/utilities/enums/sensor.dart';
import 'package:uke_mlab/models/system_state.dart';

class GraphAlarmMessage extends StatelessWidget {
  final sensorEnumAbsolute sensor;

  const GraphAlarmMessage({
    Key? key,
    required this.sensor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SystemState systemState = Get.find<SystemState>();

    return Obx(() {
      String alarmMessage = systemState.alarmState[sensor]!["message"];
      return Text(
        '$alarmMessage: ${sensor.displayString}',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      );
    });
  }
}
