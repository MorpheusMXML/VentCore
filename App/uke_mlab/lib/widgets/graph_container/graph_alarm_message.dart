import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/utilities/enums/sensor.dart';
import 'package:uke_mlab/utilities/enums/boundary_state.dart';
import 'package:uke_mlab/models/system_state.dart';

class GraphAlarmMessage extends StatelessWidget {
  final sensorEnum sensor;

  const GraphAlarmMessage({
    Key? key,
    required this.sensor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SystemState systemState = Get.find<SystemState>();
    var alarmType = systemState.violationStates[sensor] as boundaryStateEnum;

    return Text(
      '${alarmType.name}: ${sensor.displayString}',
      style: const TextStyle(color: Colors.white, fontSize: 20),
    );
  }
}
