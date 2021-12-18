import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/providers/mockup.dart';
import 'package:uke_mlab/widgets/graph/history_graph.dart';
import 'package:uke_mlab/widgets/value_box/value_box.dart';
import 'package:uke_mlab/widgets/graph/graph.dart';

class GraphContainer extends StatelessWidget {
  final Map<String, Object?> graphData;

  const GraphContainer({
    Key? key,
    required this.graphData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if ((graphData["alarm"] as RxString).value == "alarm") {
        return Container(
          color: Colors.red,
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.fromLTRB(12, 12, 12, 24),
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
                    Container(width: 8),
                    ...getRowElements(),
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
            child: Row(children: getRowElements()),
          ),
          margin: const EdgeInsets.only(bottom: 8),
        );
      } else {
        return Container(
          margin: const EdgeInsets.only(bottom: 8),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 150),
            child: Row(children: getRowElements()),
          ),
        );
      }
    });
  }

  List<Widget> getRowElements() {
    List<Widget> graphrow = [];

    switch ((graphData["type"] as Map<String, Object>)["id"]) {
      case "NIBD":
        graphrow.add(Expanded(child: HistoryGraph(graphData: graphData)));
        break;
      default:
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
        break;
    }

    return graphrow;
  }
}
