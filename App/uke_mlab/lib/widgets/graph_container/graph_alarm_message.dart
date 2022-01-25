import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/utilities/app_theme.dart';
import 'package:uke_mlab/utilities/enums/sensor.dart';
import 'package:uke_mlab/models/system_state.dart';

// TODO: COMMENTARY
class GraphAlarmMessage extends StatelessWidget {
  final sensorEnumAbsolute sensorKey;

  const GraphAlarmMessage({
    Key? key,
    required this.sensorKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SystemState systemState = Get.find<SystemState>();

    return Obx(() {
      String alarmMessage = systemState.getAlarmStateMessage(sensorKey);
      return SizedBox(
        width: 400,
        child: Text(
          '${sensorKey.displayString} $alarmMessage',
          style: const TextStyle(
            color: AppTheme.alarmMessageColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    });
  }
}
