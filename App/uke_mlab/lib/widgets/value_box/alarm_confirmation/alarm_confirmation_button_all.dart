import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/models/system_state.dart';

class AlarmConfirmationButtonAll extends StatelessWidget {
  const AlarmConfirmationButtonAll({Key? key}) : super(key: key);

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
