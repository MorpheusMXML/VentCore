import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/providers/mockup.dart';

class GraphNotification extends StatelessWidget {
  final String type;

  const GraphNotification({
    Key? key,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MonitorController>(
        init: MonitorController(),
        builder: (controller) => getWidget(controller));
  }

  getWidget(controller) {
    if (controller.muted[type]) {
      return ElevatedButton(
        onPressed: () => controller.invertMuted(type),
        style: ElevatedButton.styleFrom(
          primary: Colors.grey[800],
          fixedSize: const Size(80, 80),
          shape: const CircleBorder(),
        ),
        child: const Icon(Icons.notifications_off, size: 40),
      );
    } else {
      return ElevatedButton(
        onPressed: () => controller.invertMuted(type),
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
