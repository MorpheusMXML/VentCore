import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/providers/mockup.dart';

class GraphAdderPopup extends StatelessWidget {
  const GraphAdderPopup({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final monitorController = Get.find<MonitorController>();

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        fixedSize: const Size(500, 150),
        primary: const Color(0xFF2A2831),
      ),
      onPressed: () => monitorController.invertGraphAdder(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          getAddGraphButton(monitorController),
          Container(width: 12),
          getAddGraphButton2(monitorController)
        ],
      ),
    );
  }

  getAddGraphButton(MonitorController monitorController) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          fixedSize: const Size(130, 60),
          primary: Colors.grey[50],
          onPrimary: Colors.black),
      onPressed: () {
        monitorController.invertGraphAdder();
        (monitorController.allGraphs[4]["visible"] as RxBool).value = true;
      },
      child: const Text(
        "Add NIBD",
        style: TextStyle(fontSize: 18),
        textAlign: TextAlign.center,
      ),
    );
  }

  // Testing adding another graph
  getAddGraphButton2(MonitorController monitorController) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          fixedSize: const Size(130, 60),
          primary: Colors.grey[50],
          onPrimary: Colors.black),
      onPressed: () {
        monitorController.invertGraphAdder();
        (monitorController.allGraphs[3]["visible"] as RxBool).value = true;
      },
      child: const Text(
        "Add A",
        style: TextStyle(fontSize: 18),
        textAlign: TextAlign.center,
      ),
    );
  }
}
