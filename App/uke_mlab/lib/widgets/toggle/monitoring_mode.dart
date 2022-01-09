import 'package:flutter/material.dart';
import 'package:uke_mlab/widgets/toggle/toggle_mode_button.dart';
import 'package:uke_mlab/widgets/value_box/value_box_tile.dart';
import 'package:uke_mlab/utilities/enums/sensor.dart';

class MonitoringMode extends StatelessWidget {
  const MonitoringMode({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          flex: 1,
          child: Row(
            children: const [
              ValueBoxTile.withHeadline(sensor: sensorEnum.nibd),
              ValueBoxTile.withHeadline(sensor: sensorEnum.pulse),
            ],
          ),
        ),
        Flexible(
          flex: 1,
          child: Row(
            children: const [
              ValueBoxTile.withHeadline(sensor: sensorEnum.mve),
              ValueBoxTile.withHeadline(sensor: sensorEnum.breathFrequency),
            ],
          ),
        ),
        const Spacer(flex: 2),
        ToggleModeButton(),
      ],
    );
  }
}