import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/providers/mockup.dart';

class GraphNotification extends StatelessWidget {
  final Map<String, Object> type;

  const GraphNotification({
    Key? key,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final monitorController = Get.find<MonitorController>();

    return ElevatedButton(
      onPressed: () => monitorController.invertMuted(type["id"] as String),
      style: ElevatedButton.styleFrom(
        primary: Colors.grey[800],
        fixedSize: const Size(80, 80),
        shape: const CircleBorder(),
      ),
      child: getWidget(monitorController),
    );
  }

  getWidget(MonitorController monitorController) {
    return Obx(
      () => (monitorController.muted[type["id"]] as RxBool).value
          ? const Icon(Icons.notifications_off, size: 40)
          : const Icon(Icons.notifications, size: 40),
    );
  }
}
