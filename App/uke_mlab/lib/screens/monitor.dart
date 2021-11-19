import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:get/get.dart';
import 'package:uke_mlab/providers/mockup.dart';

import 'package:uke_mlab/widgets/graph_container.dart';
import 'package:uke_mlab/widgets/statusbar.dart';
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
              // The containers in the column are there for spacing
              Container(height: 10),
              GraphContainer(
                  data: monitorController.data2, color: Colors.purple),
              Container(height: 10),
              GraphContainer(
                  data: monitorController.data3, color: Colors.green),
              Container(height: 10),
              const GraphAdder(),
=======

import 'package:uke_mlab/widgets/example_flexible.dart';

class Monitor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          flex: 3,
          child: Column(
            children: [
              ExampleFlexible(),
              ExampleFlexible(),
              ExampleFlexible(),
>>>>>>> c429014 ([TASK]#23 Add Readme,And Example Project)
            ],
          ),
        ),
        Flexible(
          flex: 2,
          child: Column(
            children: [
              Flexible(
                flex: 1,
<<<<<<< HEAD
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
=======
                child: Container(height: 100, color: Colors.amber),
              ),
              Flexible(
                flex: 1,
                child: Container(height: 100, color: Colors.blue),
              ),
              Flexible(
                flex: 2,
                child: Container(height: 100, color: Colors.purple),
>>>>>>> c429014 ([TASK]#23 Add Readme,And Example Project)
              ),
            ],
          ),
        )
      ],
    );
  }
}
