import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/models/data_models/model_absolute.dart';
import 'package:uke_mlab/providers/screen_controller.dart';

// TODO: COMMENTARY
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
    void Function(DataModelAbsolute, double) setFunction;
    int startItem;

    if (type == 'upper') {
      startItem = dataModel.floatRepresentation
          ? (dataModel.upperAlarmBound.value * 10).toInt()
          : dataModel.upperAlarmBound.value.toInt();
      setFunction = screenController.setUpperBoundary;
    } else {
      startItem = dataModel.floatRepresentation
          ? (dataModel.lowerAlarmBound.value * 10).toInt()
          : dataModel.lowerAlarmBound.value.toInt();
      setFunction = screenController.setLowerBoundary;
    }

    return ConstrainedBox(
        constraints: BoxConstraints(maxHeight: height, maxWidth: width),
        child: ListWheelScrollView(
            controller: FixedExtentScrollController(
              initialItem: startItem,
            ),
            physics: const BouncingScrollPhysics(),
            overAndUnderCenterOpacity: 0.2,
            squeeze: 1,
            itemExtent: 40,
            diameterRatio: 1.5,
            magnification: 1.5,
            onSelectedItemChanged: (value) => setFunction(
                  dataModel,
                  dataModel.floatRepresentation
                      ? value.toDouble() / 10
                      : value.toDouble(),
                ),
            children: dataModel.floatRepresentation
                ? [
                    for (double i = 0.0; i < 200.1; i = i + 0.1)
                      Text(
                        i.toStringAsFixed(1),
                        style: TextStyle(
                          color: dataModel.color,
                          fontSize: 12,
                          decoration: TextDecoration.none,
                          fontFamily: 'Jura',
                        ),
                      )
                  ]
                : [
                    for (int i = 0; i < 400; i++)
                      Text(
                        '$i',
                        style: TextStyle(
                          color: dataModel.color,
                          fontSize: 12,
                          decoration: TextDecoration.none,
                          fontFamily: 'Jura',
                        ),
                      )
                  ]));
  }
}
