import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/models/screen_element_models/absolute_alarm_field_model.dart';
import 'package:uke_mlab/models/system_state.dart';
import 'package:uke_mlab/widgets/value_box/alarm_confirmation/alarm_confirmation_button_single_list.dart';

class AlarmConfirmationButtonSingle extends StatelessWidget {
  const AlarmConfirmationButtonSingle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemState systemState = Get.find<SystemState>();

    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          Colors.black,
        ),
        shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(40))),
      ),
      onPressed: () => systemState.absAlarmFieldModel.listExpanded.value
          ? hideOverlay(context)
          : showOverlay(context),
      // add check whether alarms are present
      child: const Text("Single Alarm Conf"),
    );
  }

  void showOverlay(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;
    AbsAlarmFieldModel fieldModel = Get.find<SystemState>().absAlarmFieldModel;

    fieldModel.entry = OverlayEntry(
      builder: (context) => const Positioned(
        left: 500,
        top: 500,
        child: AlarmButtonAbsoluteList(),
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
