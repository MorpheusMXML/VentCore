import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GraphNotification extends StatelessWidget {
  final Map<String, Object?> graphData;

  const GraphNotification({
    Key? key,
    required this.graphData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => (graphData["muted"] as RxBool).value =
          !(graphData["muted"] as RxBool).value,
      style: ElevatedButton.styleFrom(
        primary: Colors.grey[800],
        fixedSize: const Size(80, 80),
        shape: const CircleBorder(),
      ),
      child: getWidget(),
    );
  }

  getWidget() {
    return Obx(
      () => (graphData["muted"] as RxBool).value
          ? const Icon(Icons.notifications_off, size: 40)
          : const Icon(Icons.notifications, size: 40),
    );
  }
}
