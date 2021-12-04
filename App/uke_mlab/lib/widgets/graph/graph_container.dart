import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/providers/mockup.dart';
import 'package:uke_mlab/widgets/graph/graph_notification.dart';
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
                    children: [
                      const GraphNotification(),
                      Expanded(
                        child: Graph(
                          type: data[index]["type"] as String,
                          data: data[index]["data"] as List<ChartData>,
                          color: data[index]["color"] as Color,
                        ),
                      ),
                      ValueBox(
                        value: data[index]["data"] as List<ChartData>,
                        textColor: data[index]["color"] as Color,
                        backgroundColor: const Color(0xFF2A2831),
                      ),
                    ],
                  ),
                ),
              );
            },
          )),
    );
  }
}
