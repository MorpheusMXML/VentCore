import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/providers/mockup.dart';
import 'package:uke_mlab/widgets/graph/graph_notification.dart';
import 'package:uke_mlab/widgets/graph/history_graph.dart';
import 'package:uke_mlab/widgets/value_box.dart';
import 'package:uke_mlab/widgets/graph/graph.dart';

class GraphContainer extends StatelessWidget {
  final List<Map<String, Object>> data;

  const GraphContainer({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Obx(() => ListView.builder(
            itemCount: data.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin: const EdgeInsets.only(bottom: 8),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxHeight: 150),
                  child: Row(
                    children: buildGraphlist(index),
                  ),
                ),
              );
            },
          )),
    );
  }

  List<Widget> buildGraphlist(int index) {
    if (data[index]['type'] == '4') {
      return [
        const GraphNotification(),
        Expanded(
          child: HistoryGraph(
            type: data[index]["type"] as String,
            data: data[index]["data"] as List<NIBDdata>,
            color: data[index]["color"] as Color,
          ),
        ),
      ];
    } else {
      return [
        const GraphNotification(),
        Expanded(
          child: Graph(
            type: data[index]["type"] as String,
            data: data[index]["data"] as List<ChartDataMockup>,
            color: data[index]["color"] as Color,
          ),
        ),
        ValueBox(
          value: data[index]["data"] as List<ChartDataMockup>,
          textColor: data[index]["color"] as Color,
          backgroundColor: const Color(0xFF2A2831),
        ),
      ];
    }
  }
}
