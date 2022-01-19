import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/models/data_models/model_absolute.dart';
import 'package:uke_mlab/utilities/constants/absolute_alarm_field_constants.dart';

class AlarmConfirmationRowEntry extends StatelessWidget {
  const AlarmConfirmationRowEntry({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        /*child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Text for sensor
          Flexible(
            fit: FlexFit.loose,
            child: Text(
              "${sensor.name}:\n${systemState.alarmState[sensor]!["message"]}",
              style: TextStyle(
                color: Get.find<DataModelAbsolute>(tag: sensor.name).color,
                fontSize: 20,
                decoration: TextDecoration.none,
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
              primary: Get.find<DataModelAbsolute>(tag: sensor.name).color,
              onPrimary: Theme.of(context).dividerColor,
            ),
            onPressed: alarmController.confirmMap.containsKey(sensor)
                ? null
                : () => {alarmController.triggerConfirm(sensor)},
            child: const Icon(
              Icons.check,
              color: Colors.black,
            ),
          ),
        ],
      ),*/
        );
  }
}
