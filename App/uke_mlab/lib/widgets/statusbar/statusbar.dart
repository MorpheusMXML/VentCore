import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/providers/mockup.dart';
import 'package:uke_mlab/providers/start_screen_controller.dart';

class StatusBar extends StatelessWidget {
  const StatusBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final monitorController = Get.find<MonitorController>();
    final startScreenController = Get.find<StartScreenController>();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          flex: 5,
          child: Obx(
            () => Text(
              monitorController.alarmMessage.value,
              style: TextStyle(
                  color: monitorController.alarmMessage.value == ""
                      ? Colors.white
                      : Colors.red,
                  decoration: TextDecoration.none),
            ),
          ),
        ),
        Flexible(
          flex: 1,
          child: Text(
            startScreenController.selectedString.toString(),
            style: const TextStyle(
              color: Colors.white,
              decoration: TextDecoration.none,
            ),
          ),
        ),
        const Flexible(
          flex: 1,
          child: Text(
            "14:23",
            style:
                TextStyle(color: Colors.white, decoration: TextDecoration.none),
          ),
        ),
        const Flexible(
          flex: 1,
          child: Icon(Icons.battery_full, color: Colors.white),
        )
      ],
    );
  }
}
