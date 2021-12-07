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
          // TODO BUGFIX: not updated correctly?
          // 3 graphs --> update function called 3 times
          // 4 graphs --> update function called 7 times?
          ElevatedButton(
            onPressed: () {
              Map<String, Object> type = {
                "id": "NIBD",
                "index": controller.initialGraphs.length
              };
              controller.muted[type["id"] as String] = false;
              controller.initialGraphs.add(
                {
                  "type": type,
                  "data": controller.initialNIBD,
                  "color": Colors.purple,
                  "count": 0
                },
              );
            },
            child: const Text(
              "Add NIBD",
              style: TextStyle(color: Colors.black),
            ),
          ),

          // Hardcoded, later own widget, don't forget to create data in DataProvider
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
                  "type": "4",
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
