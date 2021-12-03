import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/providers/mockup.dart';
import 'package:uke_mlab/widgets/graph/graph_notification.dart';
import 'package:uke_mlab/widgets/value_box.dart';
import 'package:uke_mlab/widgets/graph/graph.dart';

class GraphContainer extends StatelessWidget {
  final List<ChartData> data;
  final Color color;
  final String type;

  const GraphContainer({
    Key? key,
    required this.type,
    required this.data,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 2,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 150),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const GraphNotification(),
            Container(width: 10),
            Expanded(
              child: Graph(
                type: type,
                data: data,
                color: color,
              ),
            ),
            Container(width: 10),
            Obx(
              () => ValueBox(
                value: data[data.length - 2].value,
                textColor: color,
                backgroundColor: const Color(0xff2A2831),
              ),
            )
          ],
        ),
      ),
    );
  }
}
