import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/models/data_models/model_absolute.dart';
import 'package:uke_mlab/models/system_state.dart';
import 'package:uke_mlab/providers/alarm_controller.dart';
import 'package:uke_mlab/utilities/app_theme.dart';
import 'package:uke_mlab/utilities/constants/absolute_alarm_field_constants.dart';
import 'package:uke_mlab/utilities/enums/sensor.dart';

/// Provides an entry for [AlarmConfirmationButtonSingleListExpansion]s list.
///
/// It contains its sensors name, the message of the alarm and a button to confirm the alarm
class AlarmConfirmationRowEntry extends StatelessWidget {
  final sensorEnumAbsolute sensorKey;

  const AlarmConfirmationRowEntry({Key? key, required this.sensorKey})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final SystemState systemState = Get.find<SystemState>();
    final AlarmController alarmController = Get.find<AlarmController>();

    return Material(
      color: Colors.transparent,
      child: Container(
        margin: const EdgeInsets.only(
            bottom: AbsoluteAlarmFieldConst.verticalMargin),
        color: theme.primarySwatch[70],
        padding: const EdgeInsets.only(
            top: AbsoluteAlarmFieldConst.verticalMargin / 4,
            bottom: AbsoluteAlarmFieldConst.verticalMargin / 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Text for sensor
            Flexible(
              flex: 1,
              fit: FlexFit.loose,
              child: Text(
                "${sensorKey.name}:\n${systemState.alarmState[sensorKey]!["message"]}",
                style: TextStyle(
                  color: Get.find<DataModelAbsolute>(tag: sensorKey.name).color,
                  fontSize: 20,
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // Confirm Button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                minimumSize:
                    Size(60, AbsoluteAlarmFieldConst.ippvHeight / 4 - 20),
                maximumSize:
                    Size(60, AbsoluteAlarmFieldConst.ippvHeight / 4 - 20),
                primary: Get.find<DataModelAbsolute>(tag: sensorKey.name).color,
                onPrimary: theme.contrastColor,
              ),
              onPressed: () => alarmController.triggerConfirm(sensorKey),
              child: Icon(
                Icons.check,
                color: theme.inverseContrastColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
