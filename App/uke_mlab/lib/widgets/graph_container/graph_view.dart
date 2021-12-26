import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/models/system_state.dart';
import 'package:uke_mlab/widgets/graph/graph_adder.dart';
import 'package:uke_mlab/widgets/graph/graph_adder_popup.dart';
import 'graph_container.dart';

class GraphView extends StatelessWidget {
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
                itemCount: systemState.graphList.length,
                itemBuilder: (BuildContext context, int index) {
                  return GraphContainer(sensor: systemState.graphList[index]);
                },
              ),
            ),
          ),
          Obx(
            () => systemState.addGraph.value
                ? GraphAdderPopup()
                : const GraphAdder(),
          ),
        ],
      ),
    );
  }
}
