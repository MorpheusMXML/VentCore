import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/models/system_state.dart';
import 'package:uke_mlab/providers/start_screen_controller.dart';

import 'package:uke_mlab/providers/style_controller.dart';
import 'package:uke_mlab/providers/toggle_controller.dart';

import 'package:uke_mlab/widgets/graph/graph_container.dart';
import 'package:uke_mlab/widgets/info/info_tile.dart';
import 'package:uke_mlab/widgets/toggle/mode_toggle_button.dart';
import 'package:uke_mlab/widgets/setting/setting_tile.dart';
import 'package:uke_mlab/widgets/value_box/value_tile.dart';
import 'package:uke_mlab/widgets/graph/graph_adder.dart';

import 'package:uke_mlab/models/enums.dart';
import 'package:uke_mlab/models/model_manager.dart';

import 'package:uke_mlab/utilities/screen_controller.dart';

class Monitor extends StatelessWidget {
  final ModelManager modelManager = Get.find();
  final ScreenController screenController = Get.find();
  final styleController = Get.put(StyleController());
  final toggleController = Get.find<ToggleController>();
  final SystemState systemState = Get.find<SystemState>();
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
          return Row(children: [
            Flexible(flex: 4, child: getGraphView()),
            Flexible(flex: 2, child: ventilationToggleView())
          ]);
        } else if (toggleController.isSelected[2]) {
          // Defibrillation
          return Row(children: [
            Flexible(flex: 4, child: getGraphView()),
            Flexible(flex: 2, child: defibrillationToggleView())
          ]);
        } else {
          // Monitoring
          return Row(children: [
            Flexible(flex: 4, child: getGraphView()),
            Flexible(flex: 2, child: monitoringToggleView())
          ]);
        }
      }),
    );
  }

  Widget getGraphView() {
    return Container(
      margin: const EdgeInsets.only(left: 8, right: 8),
      child: Column(
        children: [
          Expanded(
            child: Obx(
              () => ListView.builder(
                itemCount: systemState.graphList.length,
                itemBuilder: (BuildContext context, int index) {
                  return GraphContainer(sensor: systemState.graphList[index]);
                },
              ),
            ),
          ),
          const GraphAdder(),
        ],
      ),
    );
  }

  Widget monitoringToggleView() {
    return Column(
      children: [
        Flexible(
          flex: 1,
          child: Row(
            children: const [
              ValueTile(sensor: sensorEnum.nibd),
              ValueTile(sensor: sensorEnum.pulse),
            ],
          ),
        ),
        Flexible(
          flex: 1,
          child: Row(
            children: const [
              ValueTile(sensor: sensorEnum.mve),
              ValueTile(sensor: sensorEnum.breathFrequency),
            ],
          ),
        ),
        const Spacer(flex: 2),
        ModeToggleButton(),
      ],
    );
  }

  Widget ventilationToggleView() {
    List<Map<String, Object>> infoData = [
      {"type": "pPeak", "value": 50.12, "unit": " mBar"},
      {"type": "pPlat", "value": 4.58, "unit": " mBar"},
      {"type": "pMean", "value": 16.58, "unit": " mBar"},
      {"type": "MV", "value": 7.2, "unit": " l/min"}
    ];

    List<Map<String, String>> settingData = [
      {"name": "Freq.", "rate": "/min"},
      {"name": "Vt", "rate": "ml"},
      {"name": "PEEP", "rate": "mBar"},
    ];

    return Column(
      children: [
        Flexible(
          flex: 1,
          child: Row(
            children: const [
              ValueTile(
                sensor: sensorEnum.mve,
              ),
              ValueTile(
                sensor: sensorEnum.breathFrequency,
              ),
            ],
          ),
        ),
        Flexible(
          flex: 1,
          child: Row(
            children: [
              Expanded(child: InfoTile(data: infoData)),
              const ValueTile(
                sensor: sensorEnum.breathFrequency,
              ),
            ],
          ),
        ),
        Flexible(
          flex: 2,
          child: SettingTile(
            data: settingData,
          ),
        ),
        ModeToggleButton(),
      ],
    );
  }

  Widget defibrillationToggleView() {
    return ModeToggleButton();
  }
}
