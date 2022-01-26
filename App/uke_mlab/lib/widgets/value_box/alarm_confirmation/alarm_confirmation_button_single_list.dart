import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/models/system_state.dart';
import 'package:uke_mlab/utilities/app_theme.dart';
import 'package:uke_mlab/utilities/constants/absolute_alarm_field_constants.dart';
import 'package:uke_mlab/widgets/value_box/alarm_confirmation/alarm_confirmation_button_single_list_expansion_button.dart';

import 'alarm_confirmation_single_list_entry.dart';

/// The list for the overlay created by [AlarmConfirmationButtonSingleListExpansion]
///
/// Consitst of [AlarmConfirmationRowEntry]s
class AlarmButtonAbsoluteList extends StatelessWidget {
  const AlarmButtonAbsoluteList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    SystemState systemState = Get.find<SystemState>();

    return Obx(() {
      return ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: AbsoluteAlarmFieldConst.ippvHeight,
          maxWidth: AbsoluteAlarmFieldConst.width,
        ),
        child: Container(
          color: theme.primarySwatch[50],
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
