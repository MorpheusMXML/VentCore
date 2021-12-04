import 'package:flutter/material.dart';
import 'package:uke_mlab/models/enums.dart';
import 'package:uke_mlab/models/model.dart';
import 'package:uke_mlab/utilities/screen_controller.dart';

import 'package:get/get.dart';

class ValueBox extends StatelessWidget {
  final int textColor;
  // To be changed to "actual" data
  final int backgroundColor;
  final String miniTitle;
  final sensorEnum sensor;
  final ScreenController screenController = Get.find();

  ValueBox({
    Key? key,
    required this.textColor,
    // To be changed to "actual" data
    this.miniTitle = "PP",
    required this.backgroundColor,
    required this.sensor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DataModel dataModel = Get.find<DataModel>(tag: sensor.toString());

    void _buttonPressed() {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Button Tapped")));
      dataModel.updateValues(dataModel.singleData.value.value + 1.0); //testing
    }

    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Color(backgroundColor)),
      ),
      onPressed: _buttonPressed,
      child: Container(
        margin: const EdgeInsets.only(top: 8, bottom: 4, left: 4, right: 4),
        child: Column(
          children: [
            Row(
              children: [
                Flexible(
                  flex: 1,
                  child: Container(
                    width: double.maxFinite,
                    margin: const EdgeInsets.only(left: 8, top: 8),
                    child: Text(
                      miniTitle,
                      style: TextStyle(color: Color(textColor)),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Container(
                    margin: const EdgeInsets.only(right: 8, top: 8),
                    width: double.maxFinite,
                    child: Text(
                      "120",
                      style: TextStyle(
                        // doesn't work here for some reason
                        //overflow: TextOverflow.ellipsis,
                        color: Color(textColor),
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ),
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
            Obx(
              () => Text(
                "${dataModel.singleData.value.value.toInt()}",
                style: TextStyle(
                  color: Color(textColor),
                  fontSize: 80,
                ),
              ),
            ),
            Row(
              children: [
                Flexible(
                  flex: 1,
                  child: Container(
                    width: double.maxFinite,
                    margin: const EdgeInsets.only(left: 8),
                    child: Text(
                      "58",
                      style: TextStyle(color: Color(textColor)),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Container(
                    margin: const EdgeInsets.only(right: 8),
                    width: double.maxFinite,
                    child: Text(
                      "1/ min.",
                      style: TextStyle(
                        // doesn't work here for some reason
                        //overflow: TextOverflow.ellipsis,
                        color: Color(textColor),
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ),
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
          ],
        ),
      ),
    );
  }
}
