import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/models/model.dart';

class ValueBox extends StatelessWidget {
  final DataModel dataModel;
  const ValueBox({
    Key? key,
    required this.dataModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Can we take away Obx here since the whole widget is wrapped in Obx?
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              dataModel.miniTitle,
              style: TextStyle(color: dataModel.color),
            ),
            Obx(() => Text(dataModel.upperAlarmBound.toString(),
                style: TextStyle(
                  color: dataModel.color,
                )))
          ]),
          Obx(() => Text(
                dataModel.singleData.value.value.toInt().toString(),
                style: TextStyle(color: dataModel.color, fontSize: 50.0),
              )),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Obx(() => Text(dataModel.lowerAlarmBound.toString(),
                style: TextStyle(
                  color: dataModel.color,
                ))),
            Text('1/min',
                style: TextStyle(
                  color: dataModel.color,
                ))
          ]),
        ]);
  }
}
