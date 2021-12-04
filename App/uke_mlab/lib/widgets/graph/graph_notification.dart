import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/providers/mockup.dart';

class GraphNotification extends StatelessWidget {
  const GraphNotification({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MonitorController>(
        init: MonitorController(),
        builder: (controller) => getWidget(controller));
  }

  getWidget(controller) {
    if (controller.muted) {
      return ElevatedButton(
        onPressed: () => controller.invertMuted(),
        style: ElevatedButton.styleFrom(
          primary: Colors.grey[800],
          fixedSize: const Size(80, 80),
          shape: const CircleBorder(),
        ),
        child: const Icon(Icons.notifications_off, size: 40),
      );
    } else {
      return ElevatedButton(
        onPressed: () => controller.invertMuted(),
        style: ElevatedButton.styleFrom(
          primary: Colors.grey[800],
          fixedSize: const Size(80, 80),
          shape: const CircleBorder(),
        ),
        child: const Icon(Icons.notifications, size: 40),
      );
    }
  }
}
