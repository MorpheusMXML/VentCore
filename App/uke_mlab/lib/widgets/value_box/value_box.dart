import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:uke_mlab/utilities/screen_controller.dart';

import 'package:uke_mlab/models/enums.dart';
import 'package:uke_mlab/models/model.dart';

class ValueBox extends StatelessWidget {
  final sensorEnum sensor;

  const ValueBox({
    Key? key,
    required this.sensor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late final ScreenController screenController;
    late final DataModel dataModel;
    late Obx mainText;
    late Obx lowerAlarmBound;
    late Obx upperAlarmBound;

    dataModel = Get.find<DataModel>(tag: sensor.toString());
    var textColor = dataModel.color;
    var miniTitle = dataModel.miniTitle;

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
        dataModel.lowerAlarmBound.value.toString(),
        style: TextStyle(color: textColor),
        textAlign: TextAlign.left,
      ),
    );
    upperAlarmBound = Obx(
      () => Text(
        dataModel.upperAlarmBound.value.toString(),
        style: TextStyle(
          color: textColor,
        ),
      ),
    );

    return Obx(
      () => dataModel.tapped.value
          ? ElevatedButton(
              style: ElevatedButton.styleFrom(
                maximumSize: const Size(150, 150),
                primary: Colors.white,
                onPrimary: Colors.black,
              ),
              onPressed: () {
                dataModel.tapped.value = !dataModel.tapped.value;
              },
              child: ListWheelScrollView(
                controller: ScrollController(initialScrollOffset: 2000.0),
                children: [for (var i = 0; i <= 100; i++) Text(i.toString())],
                diameterRatio: 1.5,
                useMagnifier: true,
                magnification: 1.5,
                itemExtent: 40,
              ),
            )
          : AspectRatio(
              aspectRatio: 1,
              child: ElevatedButton(
                style: ButtonStyle(
                  shape:
                      MaterialStateProperty.all(const RoundedRectangleBorder()),
                  backgroundColor:
                      MaterialStateProperty.all(const Color(0xFF2A2831)),
                ),
                onPressed: () {
                  dataModel.tapped.value = !dataModel.tapped.value;
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
            ),
    );
  }
}
