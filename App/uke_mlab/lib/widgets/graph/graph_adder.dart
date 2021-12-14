import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/providers/mockup.dart';
import 'graph_adder_popup.dart';

class GraphAdder extends StatelessWidget {
  const GraphAdder({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final monitorController = Get.find<MonitorController>();

    return Obx(
      () => monitorController.isAddGraphTapped.value
          ? const GraphAdderPopup()
          : ElevatedButton(
              onPressed: () => monitorController.invertGraphAdder(),
              style: ElevatedButton.styleFrom(
                primary: Colors.grey[800],
                fixedSize: const Size(80, 80),
                shape: const CircleBorder(),
              ),
              child: const Icon(Icons.add, size: 40),
            ),
    );
  }
}
