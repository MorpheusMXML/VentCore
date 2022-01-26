import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/providers/alarm_controller.dart';
import 'package:uke_mlab/utilities/app_theme.dart';
import 'package:uke_mlab/utilities/enums/sensor.dart';

/// Renders the button which enables the user to confirm the alarm of the [sensorKey]s alarm.
///
/// Uses [AlarmController.triggerConfirm}
/// Key to identify the corresponding sensor
///
/// {@category Widgets}
/// {@subCategory Graph Container}
class AlarmConfirmButton extends StatelessWidget {

  /// Button confirm acknowledging an alarm.

  final sensorEnumAbsolute sensorKey;

  /// Creates instance of [AlarmConfirmButton].
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
        style: theme.alarmConfirmButtonStyle,
        onPressed: () => alarmController.triggerConfirm(sensorKey),
        child: const Icon(Icons.check),
      ),
    );
  }
}
