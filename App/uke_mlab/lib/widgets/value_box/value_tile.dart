import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/models/model.dart';
import 'package:uke_mlab/providers/mockup.dart';

import 'package:uke_mlab/models/enums.dart';
import 'package:uke_mlab/widgets/value_box/value_box.dart';

class ValueTile extends StatelessWidget {
  late Color textColor;
  final Color backgroundColor;
  late String name;
  late String miniTitle;

  late List<ChartDataMockup> value;
  late sensorEnum sensor;
  late bool withModel;

  ValueTile({
    Key? key,
    required this.textColor,
    required this.name,
    required this.miniTitle,
    required this.backgroundColor,
    required this.value,
    this.withModel = false,
  }) : super(key: key);

  ValueTile.model({
    Key? key,
    required this.backgroundColor,
    required this.sensor,
    this.withModel = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ValueBox valueBox;
    if (withModel) {
      DataModel dataModel = Get.find<DataModel>(tag: sensor.toString());
      name = dataModel.title;
      textColor = dataModel.color;
      valueBox = ValueBox.model(
        backgroundColor: backgroundColor,
        sensor: sensor,
      );
    } else {
      valueBox = ValueBox(
          textColor: textColor,
          miniTitle: miniTitle,
          value: value,
          backgroundColor: backgroundColor,
          withModel: false);
    }

    return Expanded(
      child: Container(
        color: const Color(0xFF25232A),
        margin: const EdgeInsets.only(right: 8, bottom: 8),
        child: Column(
          children: [
            Flexible(
              flex: 1,
              child: Container(
                margin: const EdgeInsets.only(top: 4, bottom: 4),
                child: Text(
                  name,
                  style: TextStyle(
                    decoration: TextDecoration.none,
                    color: textColor,
                    fontSize: 20,
                    // temp fix for long names
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
            Flexible(
              // cant decrease --> pixel overflow
              flex: 3,
              child: valueBox,
            ),
          ],
        ),
      ),
    );
  }
}
