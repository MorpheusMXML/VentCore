import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/providers/mockup.dart';
import 'package:uke_mlab/widgets/graph/graph_notification.dart';
import 'package:uke_mlab/widgets/value_box.dart';
import 'package:uke_mlab/widgets/graph/graph.dart';

class GraphContainer extends StatelessWidget {
  const GraphContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final monitorController = Get.find<MonitorController>();
    List<Map<String, Object>> dataRef = monitorController.initialGraphs;

    return Expanded(
      child: Obx(
        () => ListView.builder(
          itemCount: dataRef.length,
          itemBuilder: (BuildContext context, int index) {
            Map<String, Object> graphRef = dataRef[index];
            Map<String, Object> typeRef =
                graphRef["type"] as Map<String, Object>;

            return getWidget(monitorController, typeRef, graphRef);
          },
        ),
      ),
    );
  }

  getWidget(MonitorController controller, Map<String, Object> typeRef,
      Map<String, Object> graphRef) {
    if (controller.isInAlarmState) {
      return const Text("Alarm");
    } else {
      return Container(
        margin: const EdgeInsets.only(bottom: 8),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 150),
          child: Row(
            children: [
              GraphNotification(type: typeRef),
              Container(width: 8),
              Expanded(
                child: Graph(
                  type: typeRef,
                  data: graphRef["data"] as List<ChartDataMockup>,
                  color: graphRef["color"] as Color,
                ),
              ),
              Container(width: 8),
              ValueBox(
                value: graphRef["data"] as List<ChartDataMockup>,
                textColor: graphRef["color"] as Color,
                backgroundColor: const Color(0xFF2A2831),
                withModel: false,
              ),
            ],
          ),
        ),
      );
    }
  }
}
