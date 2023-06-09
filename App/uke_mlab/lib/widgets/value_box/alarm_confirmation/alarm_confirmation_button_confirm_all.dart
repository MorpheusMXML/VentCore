import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/models/screen_element_models/absolute_alarm_field_model.dart';
import 'package:uke_mlab/models/screen_element_models/graph_list.dart';
import 'package:uke_mlab/models/system_state.dart';
import 'package:uke_mlab/providers/alarm_controller.dart';
import 'package:uke_mlab/utilities/app_theme.dart';
import 'package:uke_mlab/utilities/enums/sensor.dart';
import 'package:uke_mlab/utilities/enums/alarm_status.dart';

/// Returns a button which confirms all active alrms on the current page if any are available.
///
/// Active alarms are defined via [AbsAlarmFieldModel.activeList] and [GraphList.activeGraphAbsolutes]
///
/// {@category AlarmConfirmation}
class AlarmConfirmationButtonAll extends StatelessWidget {
  const AlarmConfirmationButtonAll({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    SystemState systemState = Get.find<SystemState>();

    return Obx(
      () => ElevatedButton(
        style: theme.alarmConfirmButtonStyle2,
        onPressed: systemState.absAlarmFieldModel.activeList.isNotEmpty ||
                systemState.graphList.activeGraphAbsolutes.isNotEmpty
            ? () => {confirmAllVisibleAlarms()}
            : null,
        child: Center(
          child: Text(
            "Confirm all Alarms",
            style: theme.boldTextStyle,
          ),
        ),
      ),
    );
  }

  /// Searches and confirms all active alarms.
  ///
  ///
  /// Active alarms are defined via [AbsAlarmFieldModel.activeList] and [GraphList.activeGraphAbsolutes]
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
              systemState.alarmState[sensorKey]!["enum"] != alarmStatus.confirmed)) {
        alarmController.triggerConfirm(sensorKey);
      }
    }
  }
}
