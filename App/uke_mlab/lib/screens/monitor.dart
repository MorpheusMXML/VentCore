import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/models/system_state.dart';
import 'package:uke_mlab/providers/start_screen_controller.dart';
import 'package:uke_mlab/models/enums.dart';

import 'package:uke_mlab/providers/toggle_controller.dart';
import 'package:uke_mlab/widgets/graph/graph_view.dart';

import 'package:uke_mlab/widgets/toggle/toggled_defibrillation.dart';
import 'package:uke_mlab/widgets/toggle/toggled_monitoring.dart';
import 'package:uke_mlab/widgets/toggle/toggled_ventilation.dart';

class Monitor extends StatelessWidget {
  final SystemState systemState = Get.find<SystemState>();
  final toggleController = Get.find<ToggleController>();
  final StartScreenController startScreenController =
      Get.find<StartScreenController>();

  Monitor({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: [BUGFIX] Child --> Continue --> Menu --> Demo Scenarios --> Exit
    // --> Skip --> ERROR
    Get.arguments != null
        ? startScreenController.selectedString.value =
            Get.arguments["patientType"]
        : print("Can't access patientType because of refresh");

    return Container(
      margin: const EdgeInsets.only(left: 12, right: 12, top: 12),
      child: Obx(() {
        if (toggleController.isSelected[1]) {
          // Ventilation

          systemState.graphList.value = [
            sensorEnum.mve,
            sensorEnum.breathFrequency,
          ];
          return Row(children: const [
            Flexible(flex: 2, child: GraphView()),
            Flexible(flex: 1, child: ToggledVentilation())
          ]);
        } else if (toggleController.isSelected[2]) {
          // Defibrillation

          systemState.graphList.value = [
            sensorEnum.heartFrequency,
            sensorEnum.co2,
            sensorEnum.nibd
          ];
          return Row(children: const [
            Flexible(flex: 2, child: GraphView()),
            Flexible(flex: 1, child: ToggledDefibrillation())
          ]);
        } else {
          // Monitoring

          systemState.graphList.value = [
            sensorEnum.heartFrequency,
            sensorEnum.co2,
            sensorEnum.pulse
          ];
          return Row(children: const [
            Flexible(flex: 2, child: GraphView()),
            Flexible(flex: 1, child: ToggledMonitoring())
          ]);
        }
      }),
    );
  }
}
