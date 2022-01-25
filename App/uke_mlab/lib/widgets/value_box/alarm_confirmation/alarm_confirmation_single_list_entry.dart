import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/models/data_models/model_absolute.dart';
import 'package:uke_mlab/models/system_state.dart';
import 'package:uke_mlab/providers/alarm_controller.dart';
import 'package:uke_mlab/utilities/constants/absolute_alarm_field_constants.dart';
import 'package:uke_mlab/utilities/enums/sensor.dart';

// TODO: COMMENTARY
class AlarmConfirmationRowEntry extends StatelessWidget {
  final sensorEnumAbsolute sensorKey;

  const AlarmConfirmationRowEntry({Key? key, required this.sensorKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SystemState systemState = Get.find<SystemState>();
    final AlarmController alarmController = Get.find<AlarmController>();

    return Container(
      margin: const EdgeInsets.only(bottom: AbsoluteAlarmFieldConst.verticalMargin),
      color: Theme.of(context).cardColor,
      padding: const EdgeInsets.only(top: AbsoluteAlarmFieldConst.verticalMargin / 4, bottom: AbsoluteAlarmFieldConst.verticalMargin / 4),
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
              ),
            ),
          ),
          // Confirm Button
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              minimumSize: Size(60, AbsoluteAlarmFieldConst.ippvHeight / 4 - 20),
              maximumSize: Size(60, AbsoluteAlarmFieldConst.ippvHeight / 4 - 20),
              primary: Get.find<DataModelAbsolute>(tag: sensorKey.name).color,
              onPrimary: Theme.of(context).dividerColor,
            ),
            onPressed: () => {alarmController.triggerConfirm(sensorKey)},
            child: const Icon(
              Icons.check,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
