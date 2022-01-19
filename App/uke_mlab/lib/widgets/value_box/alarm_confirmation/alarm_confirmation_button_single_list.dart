import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/models/system_state.dart';
import 'package:uke_mlab/providers/alarm_controller.dart';
import 'package:uke_mlab/utilities/constants/absolute_alarm_field_constants.dart';
import 'package:uke_mlab/utilities/enums/sensor.dart';

import 'alarm_confirmation_single_list_entry.dart';

class AlarmButtonAbsoluteList extends StatelessWidget {
  const AlarmButtonAbsoluteList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemState systemState = Get.find<SystemState>();

    return Obx(() {
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
              children: [
                Flexible(
                  fit: FlexFit.loose,
                  child: ListView.builder(
                      shrinkWrap: true,
                      padding: const EdgeInsets.only(
                        right: AbsoluteAlarmFieldConst.horizontalMargin,
                        left: AbsoluteAlarmFieldConst.horizontalMargin,
                      ),
                      itemCount:
                          systemState.absAlarmFieldModel.activeList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return AlarmConfirmationRowEntry();
                      }),
                ),
              ]),
        ),
      );
    });
  }
}


/*
set.isEmpty
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
                        fit: FlexFit.loose,
                        child: Container(
                          color: Theme.of(context).cardColor,
                          padding: const EdgeInsets.only(
                              top: AbsoluteAlarmFieldConst.verticalMargin / 2,
                              bottom:
                                  AbsoluteAlarmFieldConst.verticalMargin / 2),
                          child: 
                        ),
                      );
                    }
                  }).toList(), */