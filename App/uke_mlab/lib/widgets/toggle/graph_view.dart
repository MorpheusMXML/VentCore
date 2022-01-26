import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/models/system_state.dart';
import 'package:uke_mlab/widgets/graph/graph_adder.dart';
import 'package:uke_mlab/widgets/graph/graph_adder_popup.dart';
import 'package:uke_mlab/widgets/graph_container/graph_container.dart';
import '../graph_container/graph_container.dart';

/// Displays the graphs specified in [SystemState.graphList], and [GraphAdder] or [GraphAdderPopup].
/// This widget normally takes up the entire left half of the screen.
///
/// {@category Toggle}
class GraphView extends StatelessWidget {
  /// Displays a list of graphs and a button to add/remove more graphs.

  /// Creates instance of the [GraphView].
  const GraphView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SystemState systemState = Get.find<SystemState>();

    return Container(
      margin: const EdgeInsets.only(left: 8, right: 8),
      child: Column(
        children: [
          Expanded(
            child: Obx(
              () => ListView.builder(
                shrinkWrap: true,
                itemCount: systemState.graphList.list.length,
                itemBuilder: (BuildContext context, int index) {
                  return GraphContainer(sensor: systemState.graphList.list[index]);
                },
              ),
            ),
          ),
          Obx(
            () => systemState.graphList.addGraph.value ? GraphAdderPopup() : const GraphAdder(),
          ),
        ],
      ),
    );
  }
}
