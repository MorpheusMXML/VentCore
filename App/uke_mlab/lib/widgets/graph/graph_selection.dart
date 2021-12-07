import 'package:flutter/material.dart';
import 'package:uke_mlab/providers/mockup.dart';
import 'package:uke_mlab/widgets/graph/history_graph.dart';

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
              onPressed: () =>
                  controller.initialGraphs.add({"type": "3", "data": controller.initialGraphs[0]["data"] as List<ChartDataMockup>, "color": Colors.yellow}),
              child: const Text(
                "Add Graph 1",
                style: TextStyle(color: Colors.black),
              )),
          ElevatedButton(
              onPressed: () =>
                  controller.initialGraphs.add({"type": "3", "data": controller.initialGraphs[1]["data"] as List<ChartDataMockup>, "color": Colors.green}),
              child: const Text(
                "Add Graph 2",
                style: TextStyle(color: Colors.black),
              )),
          ElevatedButton(
              onPressed: () => controller.initialGraphs.add({"type": "4", "data": controller.nibdMOCKdata, "color": Colors.red}),
              child: const Text(
                "Add NIBD History",
                style: TextStyle(color: Colors.black),
              ))
        ],
      ),
    );
  }
}
