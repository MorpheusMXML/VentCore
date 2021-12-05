import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/providers/mockup.dart';
import 'package:uke_mlab/providers/start_screen_controller.dart';
import 'package:uke_mlab/providers/style_controller.dart';

import 'package:uke_mlab/widgets/graph/graph_container.dart';
import 'package:uke_mlab/widgets/info/info_tile.dart';
import 'package:uke_mlab/widgets/setting/setting_tile.dart';
import 'package:uke_mlab/widgets/statusbar.dart';
import 'package:uke_mlab/widgets/value_tile.dart';
import 'package:uke_mlab/widgets/graph/graph_adder.dart';
import 'package:uke_mlab/models/model.dart';
import 'package:uke_mlab/utilities/screen_controller.dart';

class Monitor extends StatelessWidget {
  final ModelManager modelManager = Get.find();
  final ScreenController screenController = Get.find();

  Monitor({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final monitorController = Get.find<MonitorController>();
    final styleController = Get.put(StyleController());
    final startScreenController = Get.find<StartScreenController>();

    return Scaffold(
      appBar: AppBar(
        title: StatusBar(
          category: startScreenController.selected.toString(),
        ),
      ),
      body: Row(
        children: [
          Flexible(
            flex: 4,
            child: Container(
              margin: const EdgeInsets.only(left: 8, right: 8),
              child: Column(
                children: [
                  GraphContainer(
                    data: monitorController.initialGraphs,
                  ),
                  const GraphAdder(),
                ],
              ),
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
                      ValueTile(
                        name: "NIDB",
                        textColor: const Color(0xFFDC362E),
                        backgroundColor: const Color(0xFF2A2831),
                        value: monitorController.initialGraphs[0]["data"]
                            as List<ChartDataMockup>,
                      ),
                      ValueTile(
                        name: "Pulse",
                        textColor: const Color(0xFFFF00E4),
                        backgroundColor: const Color(0xFF2A2831),
                        value: monitorController.initialGraphs[0]["data"]
                            as List<ChartDataMockup>,
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
                        textColor: const Color(0xFF0CECDD),
                        backgroundColor: const Color(0xff2A2831),
                        value: monitorController.initialGraphs[0]["data"]
                            as List<ChartDataMockup>,
                      ),
                      ValueTile(
                        name: "Breath. Freq.",
                        textColor: const Color(0xFF0CECDD),
                        backgroundColor: const Color(0xff2A2831),
                        value: monitorController.initialGraphs[0]["data"]
                            as List<ChartDataMockup>,
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
                        child: InfoTile(data: [
                          {"type": "pPeak", "value": 50.12, "unit": "mBar"},
                          {"type": "pPlat", "value": 4.58, "unit": "mBar"},
                          {"type": "pMean", "value": 16.58, "unit": "mBar"},
                          {"type": "MV", "value": 7.2, "unit": "l/min"}
                        ]),
                      ),
                      Flexible(
                        flex: 1,
                        child: SettingTile(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
