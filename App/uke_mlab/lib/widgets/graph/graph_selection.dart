import 'package:flutter/material.dart';
import 'package:uke_mlab/providers/mockup.dart';

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
              onPressed: () {
                String type = (controller.initialGraphs.length + 1).toString();
                controller.muted[type] = false;
                controller.initialGraphs.add({
                  "type": type,
                  "data": controller.initialGraphs[0]["data"]
                      as List<ChartDataMockup>,
                  "color": Colors.yellow
                });
              },
              child: const Text(
                "Add Graph 1",
                style: TextStyle(color: Colors.black),
              )),
          ElevatedButton(
              onPressed: () {
                String type = (controller.initialGraphs.length + 1).toString();
                controller.muted[type] = false;
                controller.initialGraphs.add({
                  "type": type,
                  "data": controller.initialGraphs[1]["data"]
                      as List<ChartDataMockup>,
                  "color": Colors.yellow
                });
              },
              child: const Text(
                "Add Graph 2",
                style: TextStyle(color: Colors.black),
              )),
          ElevatedButton(
              onPressed: () {
                String type = (controller.initialGraphs.length + 1).toString();
                controller.muted[type] = false;
                controller.initialGraphs.add({
                  "type": type,
                  "data": controller.initialGraphs[2]["data"]
                      as List<ChartDataMockup>,
                  "color": Colors.yellow
                });
              },
              child: const Text(
                "Add Graph 3",
                style: TextStyle(color: Colors.black),
              ))
        ],
      ),
    );
  }
}
