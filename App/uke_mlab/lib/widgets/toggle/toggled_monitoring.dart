import 'package:flutter/material.dart';
import 'package:uke_mlab/widgets/toggle/mode_toggle_button.dart';
import 'package:uke_mlab/widgets/value_box/value_tile.dart';
import 'package:uke_mlab/models/enums.dart';

class ToggledMonitoring extends StatelessWidget {
  const ToggledMonitoring({
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
              ValueTile(sensor: sensorEnum.nibd),
              ValueTile(sensor: sensorEnum.pulse),
            ],
          ),
        ),
        Flexible(
          flex: 1,
          child: Row(
            children: const [
              ValueTile(sensor: sensorEnum.mve),
              ValueTile(sensor: sensorEnum.breathFrequency),
            ],
          ),
        ),
        const Spacer(flex: 2),
        ModeToggleButton(),
      ],
    );
  }
}