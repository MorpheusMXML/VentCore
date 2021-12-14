import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/providers/mockup.dart';
import 'package:uke_mlab/widgets/graph/graph_notification.dart';
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
    return Obx(
      () => ((graphData["alarm"] as RxBool).value)
          ? Container(
              color: Colors.red,
              padding: const EdgeInsets.all(12),
              child: Container(
                margin: const EdgeInsets.only(bottom: 8),
                child: getGraphRow(),
              ),
            )
          : Container(
              margin: const EdgeInsets.only(bottom: 8),
              child: getGraphRow(),
            ),
    );
  }

  getGraphRow() {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 150),
      child: Row(
        children: [
          GraphNotification(graphData: graphData),
          Container(width: 8),
          Expanded(
            child: (graphData["type"] as Map<String, Object>)["id"] == "NIBD"
                ? HistoryGraph(
                    color: Colors.red,
                    data: graphData["data"] as List<NIBDdata>)
                : Graph(
                    graphData: graphData,
                  ),
          ),
          Container(width: 8),
          (graphData["type"] as Map<String, Object>)["id"] == "NIBD"
              ? Container()
              : ValueBox(
                  value: graphData["data"] as List<ChartDataMockup>,
                  miniTitle: (graphData["type"] as Map<String, Object>)["abbr"]
                      as String,
                  textColor: graphData["color"] as Color,
                  backgroundColor: const Color(0xFF2A2831),
                  withModel: false,
                ),
        ],
      ),
    );
  }
}
