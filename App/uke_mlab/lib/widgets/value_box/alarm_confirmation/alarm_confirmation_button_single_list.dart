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
            top: AbsoluteAlarmFieldConst.verticalMargin * 1.5,
          ),
          margin: const EdgeInsets.only(
              bottom: AbsoluteAlarmFieldConst.verticalMargin),
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
                        return AlarmConfirmationRowEntry(
                            sensorKey: systemState
                                .absAlarmFieldModel.activeList[index]);
                      }),
                ),
              ]),
        ),
      );
    });
  }
}
