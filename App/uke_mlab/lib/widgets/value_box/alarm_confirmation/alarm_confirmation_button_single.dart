import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/models/screen_element_models/absolute_alarm_field_model.dart';
import 'package:uke_mlab/models/system_state.dart';
import 'package:uke_mlab/providers/alarm_controller.dart';
import 'package:uke_mlab/utilities/constants/absolute_alarm_field_constants.dart';
import 'package:uke_mlab/utilities/enums/sensor.dart';
import 'package:uke_mlab/widgets/value_box/alarm_confirmation/alarm_confirmation_button_single_list.dart';

class AlarmConfirmationButtonSingle extends StatelessWidget {
  const AlarmConfirmationButtonSingle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AbsAlarmFieldModel alarmFieldModel =
        Get.find<SystemState>().absAlarmFieldModel;
    //Set<sensorEnumAbsolute> set = alarmFieldModel.getActiveSet();

    //TODO put into Obx for update when solution to the problem below has been found
    return Obx(() {
      return ElevatedButton(
        style: ElevatedButton.styleFrom(
          fixedSize: Size(AbsoluteAlarmFieldConst.buttonHeight.toDouble(),
              AbsoluteAlarmFieldConst.width * (3 / 8)),
          primary: const Color(0xffeeeeee),
          onPrimary: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(75),
          ),
        ),
        onPressed:
            false // TODO add check whether alarms are present in current map without using set directly which leads to concurrency issues
                ? null
                : () => alarmFieldModel.listExpanded.value
                    ? hideOverlay(context)
                    : showOverlay(context),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Single Alarm Conf"),
            alarmFieldModel.listExpanded.value
                ? const Icon(
                    Icons.arrow_downward_rounded,
                    color: Colors.black,
                    size: AbsoluteAlarmFieldConst.buttonHeight * 0.6,
                  )
                : const Icon(
                    Icons.arrow_upward_rounded,
                    color: Colors.black,
                    size: AbsoluteAlarmFieldConst.buttonHeight * 0.6,
                  ),
          ],
        ),
      );
    });
  }

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

  void hideOverlay(BuildContext context) {
    AbsAlarmFieldModel fieldModel = Get.find<SystemState>().absAlarmFieldModel;
    fieldModel.entry?.remove();
    fieldModel.entry = null;
    fieldModel.listExpanded.value = false;
  }
}
