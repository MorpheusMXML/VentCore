import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/providers/mockup.dart';
import 'package:uke_mlab/widgets/graph/graph_notification.dart';
import 'package:uke_mlab/widgets/graph/history_graph.dart';
import 'package:uke_mlab/widgets/value_box/value_box.dart';
import 'package:uke_mlab/widgets/graph/graph.dart';

class GraphContainer extends StatelessWidget {
  final Map<String, Object> graphData;

  const GraphContainer({
    Key? key,
    required this.graphData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //if ((graphRef["alarm"] as RxBool).value) {
    //  return const Text("Alarm");
    //} else {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 150),
        child: Row(
          children: [
            GraphNotification(type: graphData["type"] as Map<String, Object>),
            Container(width: 8),
            Expanded(
              child: (graphData["type"] as Map<String, Object>)["id"] == "NIBD"
                  ? HistoryGraph(
                      color: Colors.red,
                      data: graphData["data"] as List<NIBDdata>)
                  : Graph(
                      type: graphData["type"] as Map<String, Object>,
                      data: graphData["data"] as List<ChartDataMockup>,
                      color: graphData["color"] as Color,
                    ),
            ),
            Container(width: 8),
            (graphData["type"] as Map<String, Object>)["id"] == "NIBD"
                ? Container()
                : ValueBox(
                    value: graphData["data"] as List<ChartDataMockup>,
                    miniTitle: (graphData["type"]
                        as Map<String, Object>)["abbr"] as String,
                    textColor: graphData["color"] as Color,
                    backgroundColor: const Color(0xFF2A2831),
                    withModel: false,
                  ),
          ],
        ),
      ),
    );
  }
}
