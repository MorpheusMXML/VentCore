import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/providers/alarm_controller.dart';
import 'package:uke_mlab/utilities/enums/sensor.dart';

class AlarmConfirmButton extends StatelessWidget {
  final sensorEnumAbsolute sensor;
  const AlarmConfirmButton({
    Key? key,
    required this.sensor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AlarmController alarmController = Get.find<AlarmController>();

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        fixedSize: const Size(20, 20),
        primary: Theme.of(context).shadowColor,
        onPrimary: Theme.of(context).dividerColor,
      ),
      onPressed: () => {alarmController.triggerConfirm(sensor)},
      child: const Icon(Icons.check),
    );
  }
}
