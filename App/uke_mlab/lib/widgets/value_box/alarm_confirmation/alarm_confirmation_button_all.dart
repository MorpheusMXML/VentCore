import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/models/system_state.dart';
import 'package:uke_mlab/utilities/constants/absolute_alarm_field_constants.dart';

class AlarmConfirmationButtonAll extends StatelessWidget {
  const AlarmConfirmationButtonAll({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemState systemState = Get.find<SystemState>();

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
          null, // on pressed acknowledge all alarms in systemState.alarmList (on screen)
      child: const Center(
        child: Text(
          "Acknowledge all Alarms",
        ),
      ),
    );
  }
}
