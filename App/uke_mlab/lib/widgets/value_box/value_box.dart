import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:uke_mlab/providers/mockup.dart';

import 'package:uke_mlab/utilities/screen_controller.dart';

import 'package:uke_mlab/models/enums.dart';
import 'package:uke_mlab/models/model.dart';

class ValueBox extends StatelessWidget {
  final Color textColor;
  final Color backgroundColor;
  final String miniTitle;

  late List<ChartDataMockup> value;
  late sensorEnum sensor;

  final bool withModel;

  ValueBox({
    Key? key,
    required this.textColor,
    required this.value,
    this.miniTitle = "PP",
    required this.backgroundColor,
    required this.withModel,
  }) : super(key: key);

  //TODO will finally be standard constructor when both Boxes and graphs work with mockup
  ValueBox.model({
    Key? key,
    required this.textColor,
    // to be changed
    this.miniTitle = "PP",
    required this.backgroundColor,
    required this.sensor,
    required this.withModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late final ScreenController screenController;
    late final DataModel dataModel;
    final monitorController = Get.find<MonitorController>();
    late Obx mainText;
    late Obx lowerAlarmBound;
    late Obx upperAlarmBound;

    if (withModel) {
      //TODO when ready, put to class fields and delete rest
      dataModel = Get.find<DataModel>(tag: sensor.toString());

      mainText = Obx(
        () => Text(
          dataModel.singleData.value.value.toInt().toString(),
          style: TextStyle(
            color: textColor,
            fontSize: 50,
          ),
        ),
      );
      lowerAlarmBound = Obx(
        () => Text(
          // to be changed
          dataModel.lowerAlarmBound.value.toString(),
          style: TextStyle(color: textColor),
          textAlign: TextAlign.left,
        ),
      );
      upperAlarmBound = Obx(
        () => Text(
          // to be changed
          dataModel.upperAlarmBound.value.toString(),
          style: TextStyle(
            color: textColor,
          ),
        ),
      );
    } else {
      screenController = Get.find();
      mainText = Obx(
        () => Text(
          value[value.length - 1].value.toString(),
          style: TextStyle(
            color: textColor,
            fontSize: 50,
          ),
        ),
      );
      lowerAlarmBound = Obx(
        () => Text(
          // to be changed
          "58".obs.value,
          style: TextStyle(color: textColor),
          textAlign: TextAlign.left,
        ),
      );
      upperAlarmBound = Obx(
        () => Text(
          // to be changed
          "120".obs.value,
          style: TextStyle(
            color: textColor,
          ),
        ),
      );
    }

    return AspectRatio(
      aspectRatio: 1,
      child: ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all(const RoundedRectangleBorder()),
          backgroundColor: MaterialStateProperty.all(backgroundColor),
        ),
        onPressed: () {
          if (withModel) {
            dataModel.updateValues(dataModel.singleData.value.value + 1.0);
            if (dataModel.singleData.value.value.toInt() > 10) {
              monitorController.alarmMessage.value = "High pulse!";
            }
          } //testing
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  miniTitle,
                  style: TextStyle(color: textColor),
                ),
                upperAlarmBound,
              ],
            ),
            mainText, // Obx here
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                lowerAlarmBound,
                Text(
                  // to be changed
                  "1/ min.",
                  style: TextStyle(
                    color: textColor,
                  ),
                  textAlign: TextAlign.right,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
