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
    return Container(
      margin: const EdgeInsets.only(left: 20),
      height: 200,
      child: Row(
        children: [
          Flexible(
            flex: 1,
            child: Row(
              children: [
                const Flexible(
                  flex: 1,
                  child: Bell(),
                ),
                Flexible(
                  flex: 6,
                  child: Graph(
                    data: data,
                    color: color,
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: Obx(
                    () => ValueBox(
                      value: data[data.length - 1].value.toInt(),
                      textColor: 0xff0CECDD,
                      backgroundColor: 0xff2A2831,
                    ),
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
