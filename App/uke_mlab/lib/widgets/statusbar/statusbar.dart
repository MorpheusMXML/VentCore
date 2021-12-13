import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/providers/mockup.dart';

class StatusBar extends StatelessWidget {
  final String category;
  const StatusBar({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final monitorController = Get.find<MonitorController>();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Flexible(
          flex: 1,
          child: Icon(Icons.menu, color: Colors.white),
        ),
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
            category,
            style: const TextStyle(
                color: Colors.white, decoration: TextDecoration.none),
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
