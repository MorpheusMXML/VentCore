import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/providers/mockup.dart';

class GraphAdder extends StatelessWidget {
  const GraphAdder({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MonitorController>(
        init: MonitorController(),
        builder: (controller) => getWidget(controller));
  }

  getWidget(controller) {
    if (controller.isAddGraphTapped) {
      return ElevatedButton(
        onPressed: () => controller.invert(),
        style: ElevatedButton.styleFrom(
          primary: Colors.pink[800],
          fixedSize: const Size(120, 80),
          shape: const ContinuousRectangleBorder(),
        ),
        child: const Text("Popup"),
      );
    } else {
      return ElevatedButton(
        onPressed: () => controller.invert(),
        style: ElevatedButton.styleFrom(
          primary: Colors.grey[800],
          fixedSize: const Size(80, 80),
          shape: const CircleBorder(),
        ),
        child: const Icon(Icons.add, size: 40),
      );
    }
  }
}
