import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/providers/mockup.dart';
import 'package:uke_mlab/utilities/screen_controller.dart';

class ValueBox extends StatelessWidget {
  final Color textColor;
  final List<ChartDataMockup> value;
  final Color backgroundColor;
  final String miniTitle;
  //final sensorEnum sensor;
  final ScreenController screenController = Get.find();

  ValueBox({
    Key? key,
    required this.textColor,
    required this.value,
    // to be changed
    this.miniTitle = "PP",
    required this.backgroundColor,
    //required this.sensor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final DataModel dataModel = Get.find<DataModel>(tag: sensor.toString());

    void _showSnack() {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Button Tapped")));
      //dataModel.updateValues(dataModel.singleData.value.value + 1.0); //testing
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
            Obx(
              () => Text(
                value[value.length - 2].value.toString(),
                style: TextStyle(
                  color: textColor,
                  fontSize: 50,
                ),
              ),
            ),
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
