import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/providers/mockup.dart';

import 'package:uke_mlab/widgets/graph/graph_container.dart';
import 'package:uke_mlab/widgets/info/info_tile.dart';
import 'package:uke_mlab/widgets/setting/setting_tile.dart';
import 'package:uke_mlab/widgets/value_tile.dart';
import 'package:uke_mlab/widgets/graph/graph_adder.dart';

class Monitor extends StatelessWidget {
  const Monitor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final monitorController = Get.find<MonitorController>();

    return Row(
      children: [
        Flexible(
          flex: 4,
          child: Container(
            margin: const EdgeInsets.only(left: 8, right: 8),
            child: Column(
              // Add condition here?
              // If GraphAdder is tapped, render different children
              children: [
                GraphContainer(
                    type: "1",
                    data: monitorController.data,
                    color: Colors.yellow),
                // The containers in the column are there for spacing
                Container(height: 10),
                GraphContainer(
                    type: "2",
                    data: monitorController.data2,
                    color: Colors.purple),
                Container(height: 10),
                GraphContainer(
                    type: "3",
                    data: monitorController.data3,
                    color: Colors.green),
                Container(height: 10),
                const Flexible(flex: 1, child: GraphAdder()),
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
                  children: const [
                    ValueTile(
                      name: "NIDB",
                      textColor: Color(0xFFDC362E),
                      backgroundColor: Color(0xFF2A2831),
                      value: 0,
                    ),
                    ValueTile(
                        name: "Pulse",
                        textColor: Color(0xFFFF00E4),
                        backgroundColor: Color(0xFF2A2831),
                        value: 0),
                  ],
                ),
              ),
              Flexible(
                flex: 1,
                child: Row(
                  children: const [
                    ValueTile(
                      name: "MVe",
                      textColor: Color(0xFF0CECDD),
                      backgroundColor: Color(0xff2A2831),
                      value: 0,
                    ),
                    ValueTile(
                      name: "Breath. Freq.",
                      textColor: Color(0xFF0CECDD),
                      backgroundColor: Color(0xff2A2831),
                      value: 0,
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
              Flexible(
                flex: 1,
                child: Row(
                  children: const [
                    ValueTile(
                      name: "placeholder",
                      textColor: Color(0xFFFFFFFF),
                      backgroundColor: Color(0xff2A2831),
                      value: 0,
                    ),
                    ValueTile(
                      name: "placeholder",
                      textColor: Color(0xFFFFFFFF),
                      backgroundColor: Color(0xff2A2831),
                      value: 0,
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
