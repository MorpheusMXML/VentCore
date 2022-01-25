import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/models/system_state.dart';
import 'package:uke_mlab/providers/alarm_controller.dart';
import 'package:uke_mlab/utilities/constants/absolute_alarm_field_constants.dart';
import 'package:uke_mlab/utilities/enums/sensor.dart';
import 'package:uke_mlab/utilities/enums/alarm_status.dart';

// TODO: COMMENTARY
class AlarmConfirmationButtonAll extends StatelessWidget {
  const AlarmConfirmationButtonAll({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemState systemState = Get.find<SystemState>();

    return Obx(
      () => ElevatedButton(
        style: ElevatedButton.styleFrom(
          fixedSize: Size(AbsoluteAlarmFieldConst.buttonHeight.toDouble(),
              AbsoluteAlarmFieldConst.width * (3 / 8)),
          primary: const Color(0xffeeeeee),
          onPrimary: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(75),
          ),
        ),
        onPressed: systemState.absAlarmFieldModel.activeList.isNotEmpty ||
                systemState.graphList.activeGraphAbsolutes.isNotEmpty
            ? () => {confirmAllVisibleAlarms()}
            : null,
        child: const Center(
          child: Text(
            "Confirm all Alarms",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  void confirmAllVisibleAlarms() {
    SystemState systemState = Get.find<SystemState>();
    AlarmController alarmController = Get.find<AlarmController>();

    for (var sensorKey in systemState.absAlarmFieldModel.activeList) {
      alarmController.triggerConfirm(sensorKey);
    }
    for (var graphSensorKey in systemState.graphList.list) {
      sensorEnumAbsolute? sensorKey = SensorMapping.sensorMap[graphSensorKey];
      if (sensorKey != null &&
          (systemState.alarmState[sensorKey]!["enum"] != alarmStatus.none ||
              systemState.alarmState[sensorKey]!["enum"] !=
                  alarmStatus.confirmed)) {
        alarmController.triggerConfirm(sensorKey);
      }
    }
  }
}
