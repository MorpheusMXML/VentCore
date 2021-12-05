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
    // to be changed
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
    late Obx mainText;

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
    } else {
      screenController = Get.find();
      mainText = Obx(
        () => Text(
          value[value.length - 2].value.toString(),
          style: TextStyle(
            color: textColor,
            fontSize: 50,
          ),
        ),
      );
    }

    void _showSnack() {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Button Tapped")));
      if (withModel) {
        dataModel
            .updateValues(dataModel.singleData.value.value + 1.0); //testing
      }
    }

    return AspectRatio(
      aspectRatio: 1,
      child: ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all(const RoundedRectangleBorder()),
          backgroundColor: MaterialStateProperty.all(backgroundColor),
        ),
        onPressed: _showSnack,
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
                Text(
                  // to be changed
                  "120",
                  style: TextStyle(
                    color: textColor,
                  ),
                ),
              ],
            ),
            mainText, // Obx here
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  // to be changed
                  "58",
                  style: TextStyle(color: textColor),
                  textAlign: TextAlign.left,
                ),
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
