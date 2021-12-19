import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/models/enums.dart';
import 'package:uke_mlab/providers/mockup.dart';
import 'package:uke_mlab/widgets/graph/history_graph.dart';
import 'package:uke_mlab/widgets/value_box/value_box.dart';
import 'package:uke_mlab/widgets/graph/graph.dart';

class GraphContainer extends StatelessWidget {
  late Map<String, Object?> graphData;
  late sensorEnum sensor;

  final bool withModel;

  GraphContainer({
    Key? key,
    required this.graphData,
    this.withModel = false,
  }) : super(key: key);

  GraphContainer.withModel({
    Key? key,
    required this.sensor,
    this.withModel = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (withModel) {
      return Container(
        margin: const EdgeInsets.only(bottom: 8),
        child: ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 150),
            child: Row(children: [...getGraphRow()])),
      );
    } else {
      return Obx(() {
        if ((graphData["alarm"] as RxString).value == "alarm") {
          return Container(
            color: Colors.red,
            margin: const EdgeInsets.only(bottom: 8),
            padding:
                const EdgeInsets.only(top: 12, left: 12, right: 12, bottom: 24),
            child: Column(
              children: [
                ConstrainedBox(
                  constraints: const BoxConstraints(maxHeight: 150),
                  child: Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          (graphData["alarm"] as RxString).value = "suppressed";
                        },
                        child: const Text("Confirm"),
                      ),
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
        } else if ((graphData["alarm"] as RxString).value == "suppressed") {
          return Container(
            color: Colors.red,
            padding:
                const EdgeInsets.only(top: 12, left: 12, right: 12, bottom: 12),
            child: ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 150),
                child: Row(children: [...getGraphRow()])),
            margin: const EdgeInsets.only(bottom: 8),
          );
        } else {
          return Container(
            margin: const EdgeInsets.only(bottom: 8),
            child: ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 150),
                child: Row(children: [...getGraphRow()])),
          );
        }
      });
    }
  }

  List<Widget> getGraphRow() {
    List<Widget> graphrow = [];
    graphrow.add(Container(width: 8));

    if (withModel) {
      //if ((graphData["type"] as Map<String, Object>)["id"] == "NIBD") {
      //  graphrow.add(HistoryGraph(
      //      color: Colors.red, data: graphData["data"] as List<NIBDdata>));
      //} else {
      graphrow.add(Expanded(child: Graph.withModel(sensor: sensor)));
      graphrow.add(Container(width: 8));
      graphrow.add(
        ValueBox.model(
          backgroundColor: const Color(0xFF2A2831),
          sensor: sensor,
        ),
      );
      //}
    } else {
      if ((graphData["type"] as Map<String, Object>)["id"] == "NIBD") {
        graphrow.add(HistoryGraph(
             graphData: graphData));
      } else {
        graphrow.add(Expanded(child: Graph(graphData: graphData)));
        graphrow.add(Container(width: 8));
        graphrow.add(
          ValueBox(
            value: graphData["data"] as List<ChartDataMockup>,
            miniTitle:
                (graphData["type"] as Map<String, Object>)["abbr"] as String,
            textColor: graphData["color"] as Color,
            backgroundColor: const Color(0xFF2A2831),
            withModel: false,
          ),
        );
      }
    }
    return graphrow;
  }
}
