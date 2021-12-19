import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/models/enums.dart';
import 'package:uke_mlab/widgets/graph/history_graph.dart';
import 'package:uke_mlab/widgets/value_box/value_box.dart';
import 'package:uke_mlab/widgets/graph/graph.dart';

class GraphContainer extends StatelessWidget {
  final sensorEnum sensor;

  const GraphContainer({
    Key? key,
    required this.sensor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // move to model
    RxString alarmState = "none".obs;

    return Obx(
      () {
        switch (alarmState.value) {
          case "alarm":
            return Container(
              color: Colors.red,
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.only(
                  top: 12, left: 12, right: 12, bottom: 24),
              child: Column(
                children: [
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxHeight: 150),
                    child: Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            alarmState.value = "suppressed";
                          },
                          child: const Text("Confirm"),
                        ),
                        Container(width: 8),
                        ...getGraphRow(),
                      ],
                    ),
                  ),
                  Container(height: 8),
                  const Text(
                    "ALARM MESSAGE",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ],
              ),
            );
          case "suppressed":
            return Container(
              color: Colors.red,
              padding: const EdgeInsets.only(
                  top: 12, left: 12, right: 12, bottom: 12),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 150),
                child: Row(children: getGraphRow()),
              ),
              margin: const EdgeInsets.only(bottom: 8),
            );
          default:
            return Container(
              margin: const EdgeInsets.only(bottom: 8),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 150),
                child: Row(children: getGraphRow()),
              ),
            );
        }
      },
    );
  }

  List<Widget> getGraphRow() {
    List<Widget> graphrow = [];

    //if ((graphData["type"] as Map<String, Object>)["id"] == "NIBD") {
    //  graphrow.add(HistoryGraph( graphData: graphData));
    //} else {
    graphrow.add(Expanded(child: Graph(sensor: sensor)));
    graphrow.add(Container(width: 8));
    graphrow.add(
      ValueBox(
        sensor: sensor,
      ),
    );
    //}

    return graphrow;
  }
}
