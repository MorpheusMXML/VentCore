import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/models/system_state.dart';
import 'package:uke_mlab/providers/start_screen_controller.dart';

class StatusBar extends StatelessWidget {
  const StatusBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final systemState = Get.find<SystemState>();
    final startScreenController = Get.find<StartScreenController>();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          flex: 5,
          child: Obx(
            () => Text(
              systemState.alarmMessage.value,
              style: TextStyle(
                color: systemState.alarmMessage.value == ''
                    ? Colors.white
                    : Colors.red,
                decoration: TextDecoration.none,
              ),
            ),
          ),
        ),
        Flexible(
          flex: 1,
          child: Obx(
            () => Text(
              startScreenController.selectedString.value,
              style: const TextStyle(
                color: Colors.white,
                decoration: TextDecoration.none,
              ),
            ),
          ),
        ),
        const Flexible(
          flex: 1,
          child: Text(
            '14:23',
            style: TextStyle(
              color: Colors.white,
              decoration: TextDecoration.none,
            ),
          ),
        ),
      ],
    );
  }
}
