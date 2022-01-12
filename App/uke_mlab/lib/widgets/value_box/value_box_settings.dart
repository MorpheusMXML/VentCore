import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/models/model_absolute.dart';
import 'package:uke_mlab/providers/screen_controller.dart';

class ValueBoxSettings extends StatelessWidget {
  final DataModelAbsolute dataModel;
  final String type;
  final double width;
  final double height;

  const ValueBoxSettings.lower({
    Key? key,
    required this.dataModel,
    required this.width,
    required this.height,
    this.type = 'lower',
  }) : super(key: key);

  const ValueBoxSettings.upper({
    Key? key,
    required this.dataModel,
    required this.width,
    required this.height,
    this.type = 'upper',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenController = Get.find<ScreenController>();
    void Function(DataModelAbsolute, int) setFunction;
    int startItem;

    if (type == 'upper') {
      startItem = dataModel.upperAlarmBound.value;
      setFunction = screenController.setUpperBoundary;
    } else {
      startItem = dataModel.lowerAlarmBound.value;
      setFunction = screenController.setLowerBoundary;
    }

    return ConstrainedBox(
        constraints: BoxConstraints(maxHeight: height, maxWidth: width),
        child: ListWheelScrollView(
            controller: FixedExtentScrollController(initialItem: startItem),
            physics: const BouncingScrollPhysics(),
            overAndUnderCenterOpacity: 0.2,
            squeeze: 1,
            itemExtent: 40,
            diameterRatio: 1.5,
            magnification: 1.5,
            onSelectedItemChanged: (value) => setFunction(dataModel, value),
            children: List.generate(400, (index) => Text('$index'))));
  }
}
