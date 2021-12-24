import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/models/model.dart';

import 'package:uke_mlab/models/enums.dart';
import 'package:uke_mlab/widgets/value_box/value_box.dart';

class ValueTile extends StatelessWidget {
  final sensorEnum sensor;

  const ValueTile({
    Key? key,
    required this.sensor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ValueBox valueBox;

    DataModel dataModel = Get.find<DataModel>(tag: sensor.toString());
    valueBox = ValueBox(
      sensor: sensor,
    );

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
                  dataModel.title,
                  style: TextStyle(
                    decoration: TextDecoration.none,
                    color: dataModel.color,
                    fontSize: 20,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 3,
              child: valueBox,
            ),
          ],
        ),
      ),
    );
  }
}
