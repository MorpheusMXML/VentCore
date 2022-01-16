import 'package:flutter/material.dart';
import 'package:uke_mlab/widgets/toggle/toggle_mode_button.dart';
import 'package:uke_mlab/widgets/value_box/value_box_tile.dart';
import 'package:uke_mlab/utilities/enums/sensor.dart';
import 'package:uke_mlab/widgets/value_box/value_box_tile_nibd.dart';

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
              ValueBoxTileNIBD(
                sensorAbsoluteDIA: sensorEnumAbsolute.diaAbsolute,
                sensorAbsoluteSYS: sensorEnumAbsolute.sysAbsolute,
              ),
              // TODO: requires multiple constructors in  ValueBoxTile to display special elements
              ValueBoxTile.withHeadline(sensorAbsolute: sensorEnumAbsolute.pulse),
            ],
          ),
        ),
        Flexible(
          flex: 1,
          child: Row(
            children: [
              const ValueBoxTile.withHeadline(sensorAbsolute: sensorEnumAbsolute.tempAbsolute),
              Expanded(
                // This is a placeholder to ensure uniformity
                flex: 1,
                child: Container(),
              ),
            ],
          ),
        ),
        const Spacer(flex: 2),
        ToggleModeButton(),
      ],
    );
  }
}
