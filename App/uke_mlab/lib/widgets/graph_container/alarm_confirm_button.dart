import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/utilities/enums/alarm_status.dart';
import 'package:uke_mlab/utilities/enums/sensor.dart';
import 'package:uke_mlab/models/system_state.dart';

class AlarmConfirmButton extends StatelessWidget {
  final sensorEnumAbsolute sensor;
  const AlarmConfirmButton({
    Key? key,
    required this.sensor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SystemState systemState = Get.find<SystemState>();

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        fixedSize: const Size(20, 20),
        primary: Theme.of(context).shadowColor,
        onPrimary: Theme.of(context).dividerColor,
      ),
      onPressed: () =>
          {systemState.alarmState[sensor]!["enum"] = alarmStatus.confirmed},
      child: const Icon(Icons.check),
    );
  }
}
