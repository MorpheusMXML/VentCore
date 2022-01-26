import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/models/screen_element_models/absolute_alarm_field_model.dart';
import 'package:uke_mlab/models/system_state.dart';
import 'package:uke_mlab/utilities/app_theme.dart';
import 'package:uke_mlab/utilities/constants/absolute_alarm_field_constants.dart';
import 'package:uke_mlab/widgets/value_box/alarm_confirmation/alarm_confirmation_button_single_list.dart';

/// Contains a button which expands an overlay for all active, non confirmed alarms of absolute value tiles.
///
/// The List in the overlay consitst of [AlarmButtonAbsoluteList]s
class AlarmConfirmationButtonSingleListExpansion extends StatelessWidget {
  const AlarmConfirmationButtonSingleListExpansion({Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    SystemState systemState = Get.find<SystemState>();

    return Obx(() {
      return ElevatedButton(
        style: theme.alarmConfirmButtonStyle2,
        onPressed: systemState.absAlarmFieldModel.activeList.isEmpty
            ? null
            : () => systemState.absAlarmFieldModel.listExpanded.value
                ? hideOverlay(context)
                : showOverlay(context),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Single Alarm Conf",
              style: theme.boldTextStyle,
            ),
            systemState.absAlarmFieldModel.listExpanded.value
                ? Icon(
                    Icons.arrow_downward_rounded,
                    color: theme.inverseContrastColor,
                    size: AbsoluteAlarmFieldConst.buttonHeight * 0.6,
                  )
                : Icon(
                    Icons.arrow_upward_rounded,
                    color: theme.inverseContrastColor,
                    size: AbsoluteAlarmFieldConst.buttonHeight * 0.6,
                  ),
          ],
        ),
      );
    });
  }

  /// Creates and displays overlay containing [AlarmButtonAbsoluteList] in [AbsAlarmFieldModel]
  void showOverlay(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;
    AbsAlarmFieldModel fieldModel = Get.find<SystemState>().absAlarmFieldModel;

    fieldModel.entry = OverlayEntry(
      builder: (context) => Positioned(
        left: AbsoluteAlarmFieldConst.left,
        top: AbsoluteAlarmFieldConst.overlayPositionTop + statusBarHeight,
        child: const AlarmButtonAbsoluteList(),
      ),
    );
    final overlay = Overlay.of(context)!;
    overlay.insert(fieldModel.entry as OverlayEntry);
    fieldModel.listExpanded.value = true;
  }

  /// Hides and destroys current overlay containing [AlarmButtonAbsoluteList] in [AbsAlarmFieldModel]
  void hideOverlay(BuildContext context) {
    AbsAlarmFieldModel fieldModel = Get.find<SystemState>().absAlarmFieldModel;
    fieldModel.entry?.remove();
    fieldModel.entry = null;
    fieldModel.listExpanded.value = false;
  }
}
