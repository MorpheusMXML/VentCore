import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/models/system_state.dart';

import 'package:uke_mlab/providers/mockup.dart';
import 'package:uke_mlab/providers/style_controller.dart';
import 'package:uke_mlab/providers/toggle_controller.dart';

import 'package:uke_mlab/widgets/graph/graph_container.dart';
import 'package:uke_mlab/widgets/info/info_tile.dart';
import 'package:uke_mlab/widgets/toggle/mode_toggle_button.dart';
import 'package:uke_mlab/widgets/setting/setting_tile.dart';
import 'package:uke_mlab/widgets/statusbar/statusbar.dart';
import 'package:uke_mlab/widgets/value_box/value_tile.dart';
import 'package:uke_mlab/widgets/graph/graph_adder.dart';

import 'package:uke_mlab/models/model.dart';
import 'package:uke_mlab/models/enums.dart';
import 'package:uke_mlab/models/model_manager.dart';

import 'package:uke_mlab/utilities/screen_controller.dart';

class Monitor extends StatelessWidget {
  final ModelManager modelManager = Get.find();
  final ScreenController screenController = Get.find();
  final monitorController = Get.find<MonitorController>();
  final styleController = Get.put(StyleController());
  final toggleController = Get.find<ToggleController>();
  final SystemState systemState = Get.find<SystemState>();

  Monitor({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    monitorController.activateTimer();

    return Scaffold(
        appBar: AppBar(title: StatusBar(category: Get.arguments[0])),
        body: Container(
            margin: const EdgeInsets.only(left: 12, right: 12, top: 12),
            child: Obx(() => getToggledScreen())));
  }

  Widget getToggledScreen() {
    if (toggleController.isSelected[1]) {
      // Ventilation
      return Row(children: [getGraphView(), ModeToggleButton()]);
    } else if (toggleController.isSelected[2]) {
      // Defibrillation
      return Row(children: [getGraphView(), ModeToggleButton()]);
    } else {
      // Monitoring
      return Row(children: [getGraphView(), getToggleView()]);
    }
  }

  Widget getGraphView() {
    return Flexible(
      flex: 4,
      child: Container(
        margin: const EdgeInsets.only(left: 8, right: 8),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: systemState.graphList.length,
                itemBuilder: (BuildContext context, int index) {
                  return GraphContainer(sensor: systemState.graphList[index]);
                },
              ),
            ),
            const GraphAdder(),
          ],
        ),
      ),
    );
  }

  Widget getToggleView() {
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

    return Flexible(
      flex: 2,
      child: Column(
        children: [
          Flexible(
            flex: 1,
            child: Row(
              children: const [
                ValueTile(
                  sensor: sensorEnum.nibd,
                ),
                ValueTile(
                  sensor: sensorEnum.pulse,
                ),
              ],
            ),
          ),
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
            flex: 2,
            child: Row(
              children: [
                Flexible(
                  flex: 1,
                  child: InfoTile(
                    data: infoData,
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: SettingTile(
                    data: settingData,
                  ),
                ),
              ],
            ),
          ),
          ModeToggleButton(),
        ],
      ),
    );
  }
}
