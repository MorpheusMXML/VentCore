import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/models/model_absolute.dart';
import 'package:uke_mlab/models/system_state.dart';
import 'package:uke_mlab/providers/alarm_controller.dart';
import 'package:uke_mlab/utilities/constants/absolute_alarm_field_constants.dart';
import 'package:uke_mlab/utilities/enums/sensor.dart';
import 'package:uke_mlab/utilities/enums/alarm_status.dart';

class AlarmButtonAbsoluteList extends StatelessWidget {
  const AlarmButtonAbsoluteList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemState systemState = Get.find<SystemState>();

    return Obx(() {
      AlarmController alarmController = Get.find<AlarmController>();
      Set<sensorEnumAbsolute> set =
          Get.find<SystemState>().absAlarmFieldModel.getActiveSet();
      bool nonConfirmedAlarms = false;

      // checks whether there are non confirmed alarms in set.
      // feels like it could be done in getActiveSet, but that runs in to race conditions with usage in AlarmConfirmationButtonSingle
      for (var sensor in set) {
        nonConfirmedAlarms = alarmController.confirmMap.containsKey(sensor);
        if (!nonConfirmedAlarms) {
          break;
        }
      }

      if (set.isEmpty || nonConfirmedAlarms) {
        systemState.absAlarmFieldModel.entry?.remove();
        systemState.absAlarmFieldModel.entry = null;
        systemState.absAlarmFieldModel.listExpanded.value = false;
      }

      return ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: AbsoluteAlarmFieldConst.ippvHeight,
          maxWidth: AbsoluteAlarmFieldConst.width,
        ),
        child: Container(
          color: Theme.of(context).focusColor,
          padding: const EdgeInsets.only(
              left: AbsoluteAlarmFieldConst.horizontalMargin,
              right: AbsoluteAlarmFieldConst.horizontalMargin,
              top: AbsoluteAlarmFieldConst.verticalMargin * 2,
              bottom: AbsoluteAlarmFieldConst.verticalMargin * 2),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: set.isEmpty
                ? []
                : set.map((sensor) {
                    // add only sensors with current, non-confirmed alarm to concurrency issues
                    if (systemState.alarmState[sensor]!["enum"] ==
                            alarmStatus.none ||
                        alarmController.confirmMap.containsKey(sensor)) {
                      return Container();
                    } else {
                      return Flexible(
                        flex: 1,
                        child: Container(
                          color: Theme.of(context).cardColor,
                          padding: const EdgeInsets.only(
                              top: AbsoluteAlarmFieldConst.verticalMargin / 2,
                              bottom:
                                  AbsoluteAlarmFieldConst.verticalMargin / 2),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                fit: FlexFit.loose,
                                child: Text(
                                  "${sensor.name}:\n${systemState.alarmState[sensor]!["message"]}",
                                  style: TextStyle(
                                    color: Get.find<DataModelAbsolute>(
                                            tag: sensor.name)
                                        .color,
                                    fontSize: 20,
                                    decoration: TextDecoration.none,
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: const CircleBorder(),
                                  minimumSize: Size(
                                      60,
                                      AbsoluteAlarmFieldConst.ippvHeight / 4 -
                                          20),
                                  maximumSize: Size(
                                      60,
                                      AbsoluteAlarmFieldConst.ippvHeight / 4 -
                                          20),
                                  primary: Get.find<DataModelAbsolute>(
                                          tag: sensor.name)
                                      .color,
                                  onPrimary: Theme.of(context).dividerColor,
                                ),
                                onPressed: alarmController.confirmMap
                                        .containsKey(sensor)
                                    ? null
                                    : () => {
                                          alarmController.triggerConfirm(sensor)
                                        },
                                child: const Icon(
                                  Icons.check,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                  }).toList(),
          ),
        ),
      );
    });
  }
}
