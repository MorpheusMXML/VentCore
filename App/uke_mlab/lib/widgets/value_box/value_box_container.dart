import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/models/model.dart';

class ValueBoxContainer extends StatelessWidget {
  final DataModel dataModel;
  const ValueBoxContainer({
    Key? key,
    required this.dataModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: ElevatedButton(
        style: ButtonStyle(
            shape: MaterialStateProperty.all(const RoundedRectangleBorder()),
            backgroundColor:
                MaterialStateProperty.all(const Color(0xFF2A2831))),
        onPressed: () => dataModel.tapped.toggle(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Top
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text(dataModel.miniTitle,
                  style: TextStyle(color: dataModel.color)),
              Obx(() => Text(dataModel.upperAlarmBound.toString(),
                  style: TextStyle(color: dataModel.color)))
            ]),

            // Middle
            Obx(() => Text(dataModel.singleData.value.value.toInt().toString(),
                style: TextStyle(color: dataModel.color, fontSize: 50.0))),

            // Bottom
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Obx(() => Text(dataModel.lowerAlarmBound.toString(),
                  style: TextStyle(color: dataModel.color))),
              Text('1/min', style: TextStyle(color: dataModel.color))
            ]),
          ],
        ),
      ),
    );
  }
}
