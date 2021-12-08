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
          // TODO BUGFIX: not updated correctly?
          // 3 graphs --> update function called 3 times
          // 4 graphs --> update function called 7 times?
          // TODO: create widget for this button (it'll be reused)
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
                  "color": Colors.red,
                  "count": 0
                },
              );
            },
            child: const Text(
              "Add NIBD",
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
