import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/models/system_state.dart';
import 'graph_adder_popup.dart';

class GraphAdder extends StatelessWidget {
  const GraphAdder({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SystemState systemState = Get.find<SystemState>();

    return Obx(
      () => systemState.addGraph.value
          ? GraphAdderPopup()
          : ElevatedButton(
              onPressed: () => systemState.addGraph.toggle(),
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
