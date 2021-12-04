import 'package:flutter/material.dart';
import 'package:uke_mlab/providers/mockup.dart';
import 'package:uke_mlab/widgets/value_box.dart';

class GraphSelection extends StatelessWidget {
  final MonitorController controller;

  const GraphSelection({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(fixedSize: const Size(500, 150)),
      onPressed: () => controller.invert(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
              onPressed: () => controller.initialGraphs.add({
                    "type": "3",
                    "data":
                        controller.initialGraphs[0]["data"] as List<ChartData>,
                    "color": Colors.yellow
                  }),
              child: const Text(
                "Add Graph 1",
                style: TextStyle(color: Colors.black),
              )),
          ElevatedButton(
              onPressed: () => controller.initialGraphs.add({
                    "type": "3",
                    "data":
                        controller.initialGraphs[1]["data"] as List<ChartData>,
                    "color": Colors.green
                  }),
              child: const Text(
                "Add Graph 2",
                style: TextStyle(color: Colors.black),
              )),
          ElevatedButton(
              onPressed: () => controller.initialGraphs.add({
                    "type": "3",
                    "data":
                        controller.initialGraphs[2]["data"] as List<ChartData>,
                    "color": Colors.brown
                  }),
              child: const Text(
                "Add Graph 3",
                style: TextStyle(color: Colors.black),
              ))
        ],
      ),
    );
  }
}
