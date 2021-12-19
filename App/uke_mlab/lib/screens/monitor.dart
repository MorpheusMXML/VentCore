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

import 'package:uke_mlab/models/enums.dart';
import 'package:uke_mlab/models/model_manager.dart';

import 'package:uke_mlab/utilities/screen_controller.dart';

class Monitor extends StatelessWidget {
  final ModelManager modelManager = Get.find();
  final ScreenController screenController = Get.find();
  final monitorController = Get.find<MonitorController>();
  final styleController = Get.put(StyleController());
  final toggleController = Get.find<ToggleController>();

  Monitor({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    monitorController.activateTimer();

    return Scaffold(
        appBar: AppBar(
          title: StatusBar(
            category: Get.arguments[0],
          ),
        ),
        body: Obx(() => getToggledScreen()));
  }

  getToggledScreen() {
    if (toggleController.isSelected[1]) {
      return getVentilationScreen();
    } else if (toggleController.isSelected[2]) {
      return getDefibrillationScreen();
    } else {
      return getMonitorScreen();
    }
  }

  Widget getMonitorScreen() {
    var graphList = monitorController.allGraphs;
    SystemState systemState = Get.find<SystemState>();
    DataModel dataModel =
        Get.find<DataModel>(tag: sensorEnum.breathFrequency.toString());

  Widget getDefibrillationScreen() {
    return Container(
      margin: const EdgeInsets.only(left: 12, right: 12, top: 12),
      child: Row(
        children: [
          Flexible(
            flex: 4,
            child: Container(
              margin: const EdgeInsets.only(left: 8, right: 8),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: systemState.graphList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GraphContainer.withModel(
                            sensor: systemState.graphList[index]);
                      },
                    ),
                  ),
                );
              },
            ),
          ),
          Flexible(
            flex: 2,
            child: Column(
              children: [
                Flexible(
                  flex: 1,
                  child: Row(
                    children: [
                      ValueTile.model(
                        backgroundColor: const Color(0xFF2A2831),
                        sensor: sensorEnum.nibd,
                        // withModel: false,
                      ),
                      ValueTile.model(
                        //name: "Pulse",
                        //miniTitle: "PP",
                        //textColor: const Color(0xFFFF00E4),
                        backgroundColor: const Color(0xFF2A2831),
                        sensor: sensorEnum.pulse,
                        //withModel: true,
                      ),
                    ],
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Row(
                    children: [
                      ValueTile.model(
                        backgroundColor: const Color(0xff2A2831),
                        sensor: sensorEnum.mve,
                        // withModel: false,
                      ),
                      ValueTile.model(
                        backgroundColor: const Color(0xff2A2831),
                        sensor: sensorEnum.breathFrequency,
                        // withModel: false,
                      ),
                    ],
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: Row(
                    children: const [
                      Flexible(
                        flex: 1,
                        child: InfoTile(
                          data: [
                            {"type": "pPeak", "value": 50.12, "unit": " mBar"},
                            {"type": "pPlat", "value": 4.58, "unit": " mBar"},
                            {"type": "pMean", "value": 16.58, "unit": " mBar"},
                            {"type": "MV", "value": 7.2, "unit": " l/min"}
                          ],
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: SettingTile(
                          data: [
                            {"name": "Freq.", "rate": "/min"},
                            {"name": "Vt", "rate": "ml"},
                            {"name": "PEEP", "rate": "mBar"},
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                ModeToggleButton(),
              ],
            ),
          )
        ],
      ),
    );
  }

  toggleView() {
    return Column(
      children: [
        Flexible(
          flex: 1,
          child: Row(
            children: [
              ValueTile(
                name: "NIBD",
                miniTitle: "SYS",
                textColor: const Color(0xFFDC362E),
                backgroundColor: const Color(0xFF2A2831),
                value: monitorController.nibdValue,
                withModel: false,
              ),
              ValueTile.model(
                name: "Pulse",
                miniTitle: "PP",
                textColor: const Color(0xFFFF00E4),
                backgroundColor: const Color(0xFF2A2831),
                sensor: sensorEnum.pulse,
                withModel: true,
              ),
            ],
          ),
        ),
        Flexible(
          flex: 1,
          child: Row(
            children: [
              ValueTile(
                name: "MVe",
                miniTitle: "MVe",
                textColor: const Color(0xFF0CECDD),
                backgroundColor: const Color(0xff2A2831),
                value: monitorController.mveValue,
                withModel: false,
              ),
              ValueTile(
                name: "Breath. Freq.",
                miniTitle: "AF",
                textColor: const Color(0xFF0CECDD),
                backgroundColor: const Color(0xff2A2831),
                value: monitorController.breathFreqValue,
                withModel: false,
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
                child: InfoTile(data: monitorController.info),
              ),
              Flexible(
                flex: 1,
                child: SettingTile(data: monitorController.settings),
              ),
            ],
          ),
        ),
        ModeToggleButton(),
      ],
    );
  }
}
