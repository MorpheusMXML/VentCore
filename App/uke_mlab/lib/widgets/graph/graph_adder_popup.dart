import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/models/enums.dart';
import 'package:uke_mlab/models/system_state.dart';

class GraphAdderPopup extends StatelessWidget {
  final SystemState systemState = Get.find<SystemState>();

  GraphAdderPopup({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        fixedSize: const Size(500, 150),
        primary: const Color(0xFF2A2831),
      ),
      onPressed: () => systemState.addGraph.toggle(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [getAddGraphButton()],
      ),
    );
  }

  getAddGraphButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          fixedSize: const Size(130, 60),
          primary: Colors.grey[50],
          onPrimary: Colors.black),
      onPressed: () {
        systemState.addGraph.toggle();
        systemState.graphList.add(sensorEnum.nibd);
      },
      child: const Text(
        "Add NIBD",
        style: TextStyle(fontSize: 18),
        textAlign: TextAlign.center,
      ),
    );
  }
}
