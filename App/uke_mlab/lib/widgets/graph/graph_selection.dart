import 'package:flutter/material.dart';
import 'package:uke_mlab/providers/mockup.dart';

class GraphSelection extends StatelessWidget {
  final MonitorController controller;

  const GraphSelection({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        fixedSize: const Size(500, 150),
        primary: const Color(0xFF2A2831),
      ),
      onPressed: () => controller.invert(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // TODO BUGFIX: not updated correctly?
          // 3 graphs --> update function called 3 times
          // 4 graphs --> update function called 7 times?
          // TODO: create widget for this button (it'll be reused)
          getAddGraphButton("NIBD History"),
          const SizedBox(width: 50),
          getAddGraphButton("ECG Derivatives"),
        ],
      ),
    );
  }

  getAddGraphButton(String text) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          fixedSize: const Size(130, 60),
          primary: Colors.grey[50],
          onPrimary: Colors.black),
      onPressed: () {
        controller.invert();
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
      child: Text(
        text,
        style: const TextStyle(fontSize: 18),
        textAlign: TextAlign.center,
      ),
    );
  }
}
