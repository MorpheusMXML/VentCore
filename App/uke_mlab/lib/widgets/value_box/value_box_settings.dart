import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/models/model.dart';
import 'package:uke_mlab/utilities/screen_controller.dart';

class ValueBoxSettings extends StatelessWidget {
  final DataModel dataModel;
  final String type;

  const ValueBoxSettings({
    Key? key,
    required this.dataModel,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenController = Get.find<ScreenController>();

    return SizedBox(
        width: 60,
        height: 100,
        child: ListWheelScrollView(
            // onSelectedItemChange doesn't work with ScrollController 😡
            // controller: ScrollController(initialScrollOffset: 200),
            physics: const BouncingScrollPhysics(),
            overAndUnderCenterOpacity: 0.2,
            squeeze: 1,
            itemExtent: 40,
            diameterRatio: 1.5,
            magnification: 1.5,
            onSelectedItemChanged: (value) => type == 'upper'
                ? screenController.setUpperBoundary(dataModel, value)
                : screenController.setLowerBoundary(dataModel, value),
            children: List.generate(200, (index) => Text('$index'))));
  }
}
