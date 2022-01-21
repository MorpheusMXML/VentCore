import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/models/system_state.dart';
import 'package:uke_mlab/providers/start_screen_controller.dart';
import 'package:uke_mlab/utilities/enums/sensor.dart';

import 'package:uke_mlab/widgets/graph_container/graph_view.dart';

import 'package:uke_mlab/widgets/toggle/defibrillation_mode.dart';
import 'package:uke_mlab/widgets/toggle/monitoring_mode.dart';
import 'package:uke_mlab/widgets/toggle/ventilation_mode.dart';

class MainScreen extends StatelessWidget {
  final SystemState systemState = Get.find<SystemState>();
  final StartScreenController startScreenController =
      Get.find<StartScreenController>();

  MainScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(left: 12, right: 12, top: 12),

        // TODO: maybe change the default graphList elsewhere (Mode Screens?)
        child: GetBuilder<SystemState>(
          builder: (_) {
            // Ventilation
            if (systemState.selectedToggleView[1]) {
              // TODO set standard graphs for ventilation
              systemState.graphList.graphListSet([
                sensorEnumGraph.flow,
                sensorEnumGraph.paw,
                sensorEnumGraph.co2,
              ]);
              return Row(children: const [
                Flexible(flex: 2, child: GraphView()),
                Flexible(flex: 1, child: VentilationMode())
              ]);
            }
            // Defibrillation
            else if (systemState.selectedToggleView[2]) {
              // TODO set standard graphs for defibrillation
              systemState.graphList.graphListSet([
                sensorEnumGraph.ecgCh2,
                sensorEnumGraph.co2,
                sensorEnumGraph.cpr,
              ]);
              return Row(children: const [
                Flexible(flex: 2, child: GraphView()),
                Flexible(flex: 1, child: DefibrillationMode())
              ]);
            }
            // Monitoring
            else {
              systemState.graphList.graphListSet([
                sensorEnumGraph
                    .ecgCh2, // medical standard ecg channel is channel 2
                sensorEnumGraph.co2,
                sensorEnumGraph.pleth,
              ]);
              return Row(children: const [
                Flexible(flex: 2, child: GraphView()),
                Flexible(flex: 1, child: MonitoringMode())
              ]);
            }
          },
        ));
  }
}
