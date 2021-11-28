import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/providers/mockup.dart';

import 'package:uke_mlab/widgets/graph_container.dart';
import 'package:uke_mlab/widgets/value_tile.dart';
import 'package:uke_mlab/widgets/graph_adder.dart';

class Monitor extends StatelessWidget {
  const Monitor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final monitorController = Get.find<MonitorController>();

    return Row(
      children: [
        Flexible(
          flex: 4,
          child: Column(
            // Add condition here?
            // If GraphAdder is tapped, render different children
            children: [
              GraphContainer(
                  data: monitorController.data, color: Colors.yellow),
              GraphContainer(
                  data: monitorController.data2, color: Colors.purple),
              GraphContainer(
                  data: monitorController.data3, color: Colors.green),
              const GraphAdder(),
            ],
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
                      name: "Pulse",
                      textColor: 0xffFF00E4,
                      backgroundColor: 0xff2A2831,
                    ),
                    ValueTile(
                      name: "Breath. Freq.",
                      textColor: 0xff0CECDD,
                      backgroundColor: 0xff2A2831,
                    ),
                  ],
                ),
              ),
              Flexible(
                flex: 1,
                child: Container(color: Colors.amber),
              ),
              Flexible(
                flex: 1,
                child: Container(color: Colors.purple),
              ),
            ],
          ),
        )
      ],
    );
  }
}
