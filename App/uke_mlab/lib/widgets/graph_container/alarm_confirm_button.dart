import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/providers/alarm_controller.dart';
import 'package:uke_mlab/utilities/enums/sensor.dart';

class AlarmConfirmButton extends StatelessWidget {
  /// Button which enables the user to confirm the alarm of the [sensorKey]s alarm.
  ///
  /// Uses [AlarmController.triggerConfirm}

  /// Key to identify the corresponding sensor
  final sensorEnumAbsolute sensorKey;

  const AlarmConfirmButton({
    Key? key,
    required this.sensorKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AlarmController alarmController = Get.find<AlarmController>();

    return SizedBox(
      height: 25,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          fixedSize: const Size(20, 20),
          primary: Theme.of(context).shadowColor,
          onPrimary: Theme.of(context).dividerColor,
        ),
        onPressed: () => {alarmController.triggerConfirm(sensorKey)},
        child: const Icon(Icons.check),
      ),
    );
  }
}
