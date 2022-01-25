import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/providers/alarm_controller.dart';
import 'package:uke_mlab/utilities/app_theme.dart';
import 'package:uke_mlab/utilities/enums/sensor.dart';

// TODO: COMMENTARY
class AlarmConfirmButton extends StatelessWidget {
  final sensorEnumAbsolute sensorKey;
  const AlarmConfirmButton({
    Key? key,
    required this.sensorKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final AlarmController alarmController = Get.find<AlarmController>();

    return SizedBox(
      height: 25,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          fixedSize: const Size(20, 20),
          primary: theme.primarySwatch[20],
          onPrimary: theme.contrastColor,
        ),
        onPressed: () => {alarmController.triggerConfirm(sensorKey)},
        child: const Icon(Icons.check),
      ),
    );
  }
}
