import 'package:flutter/material.dart';
import 'package:uke_mlab/models/enums.dart';
import 'package:uke_mlab/widgets/value_box/value_box_tile.dart';

class AlarmLimitScreen extends StatelessWidget {
  const AlarmLimitScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: Row(children: getBoxes()),
    );
  }

  List<Widget> getBoxes() {
    List<Widget> widgets = [];

    for (var i = 0; i < sensorEnum.values.length; i++) {
      widgets.add(ValueBoxTile(sensor: sensorEnum.values[i]));
      if (i % 3 == 0) {
        widgets.add(Container(width: 20));
      }
    }

    return widgets;
  }
}
