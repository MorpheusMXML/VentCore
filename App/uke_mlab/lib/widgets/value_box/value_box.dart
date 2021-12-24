import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:uke_mlab/utilities/screen_controller.dart';

import 'package:uke_mlab/models/enums.dart';
import 'package:uke_mlab/models/model.dart';

class ValueBox extends StatelessWidget {
  final sensorEnum sensor;
  late DataModel dataModel = Get.find<DataModel>(tag: sensor.toString());

  ValueBox({
    Key? key,
    required this.sensor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ScreenController screenController;

    return Obx(
      () => dataModel.tapped.value
          ? Stack(
              clipBehavior: Clip.none,
              children: [
                getValueBox(),
                Positioned(child: getOptions(), left: 100, top: 50,),
                Positioned(child: getOptions(), right: 100, bottom: 50,),
              ],
            )
          : getValueBox(),
    );
  }

  Widget getValueBox() {
    return AspectRatio(
        aspectRatio: 1,
        child: ElevatedButton(
            style: ButtonStyle(
                shape:
                    MaterialStateProperty.all(const RoundedRectangleBorder()),
                backgroundColor:
                    MaterialStateProperty.all(const Color(0xFF2A2831))),
            onPressed: () => dataModel.tapped.toggle(),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Can we take away Obx here since the whole widget is wrapped in Obx?
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        getText(dataModel.miniTitle),
                        Obx(() => getText(dataModel.upperAlarmBound.toString()))
                      ]),
                  Obx(() => getText(
                      dataModel.singleData.value.value.toInt().toString(),
                      fontSize: 50.0)),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Obx(() =>
                            getText(dataModel.lowerAlarmBound.toString())),
                        getText("1/min")
                      ]),
                ])));
  }

  Widget getOptions() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        maximumSize: const Size(70, 100),
        primary: Colors.white.withOpacity(0.3),
        onPrimary: Colors.black,
      ),
      onPressed: () => dataModel.tapped.toggle(),
      child: ListWheelScrollView(
        controller: ScrollController(initialScrollOffset: 2000.0),
        children: [
          for (var i = 0; i <= 100; i++) Text(i.toString()),
        ],
        diameterRatio: 1.5,
        useMagnifier: true,
        magnification: 1.5,
        itemExtent: 40,
      ),
    );
  }

  Widget getText(String text, {fontSize = 14.0}) {
    return Text(
      text,
      style: TextStyle(
        color: dataModel.color,
        fontSize: fontSize,
      ),
    );
  }
}
