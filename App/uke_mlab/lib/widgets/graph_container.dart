import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/providers/mockup.dart';
import 'package:uke_mlab/widgets/bell.dart';
import 'package:uke_mlab/widgets/value_box.dart';
import 'package:uke_mlab/widgets/graph.dart';

class GraphContainer extends StatelessWidget {
  final List<ChartData> data;
  final Color color;

  const GraphContainer({
    Key? key,
    required this.data,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Flexible(
            flex: 1,
            child: Row(
              children: [
                const Bell(),
                Container(width: 10),
                Expanded(
                  child: Graph(
                    data: data,
                    color: color,
                  ),
                ),
                Container(width: 10),
                Obx(
                  () => ValueBox(
                    value: data[data.length - 1].value,
                    textColor: color,
                    backgroundColor: const Color(0xff2A2831),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
