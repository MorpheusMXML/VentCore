import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/providers/mockup.dart';
import 'package:uke_mlab/widgets/add_button.dart';

import 'graph_selection.dart';

class GraphAdder extends StatelessWidget {
  const GraphAdder({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MonitorController>(
        init: MonitorController(),
        builder: (controller) => getWidget(controller));
  }

  getWidget(controller) {
    if (controller.isAddGraphTapped) {
      return GraphSelection(controller: controller);
    } else {
      return AddButton(controller: controller);
    }
  }
}
