import 'package:flutter/material.dart';
import 'package:uke_mlab/widgets/toggle/toggle_mode_button.dart';
import 'package:uke_mlab/widgets/value_box/alarm_confirmation/alarm_confirmation_button_row.dart';
import 'package:uke_mlab/widgets/value_box/value_box_tile.dart';
import 'package:uke_mlab/utilities/enums/sensor.dart';
import 'package:uke_mlab/widgets/value_box/value_box_tile_nibd.dart';

class MonitoringMode extends StatelessWidget {
  const MonitoringMode({
    Key? key,
    absoluteValueBoxTiles,
  }) : super(key: key);

  // TODO get elements to be added to vent Screen from systemState.absAlarmFieldModel respective Set
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          flex: 8,
          child: Row(
            children: const [
              ValueBoxTileNIBD(
                sensorAbsoluteDIA: sensorEnumAbsolute.diaAbsolute,
                sensorAbsoluteSYS: sensorEnumAbsolute.sysAbsolute,
              ),
              // TODO: requires multiple constructors in  ValueBoxTile to display special elements
              Expanded(
                child: ValueBoxTile.withHeadline(
                    sensorAbsolute: sensorEnumAbsolute.pulse),
              ),
            ],
          ),
        ),
        Flexible(
          flex: 8,
          child: Row(
            children: [
              const Expanded(
                child: ValueBoxTile.withHeadline(
                    sensorAbsolute: sensorEnumAbsolute.tempAbsolute),
              ),
              Expanded(
                // This is a placeholder to ensure uniformity
                flex: 1,
                child: Container(),
              ),
            ],
          ),
        ),
        const Spacer(flex: 13),
        const Flexible(
          flex: 3,
          child: AlarmConfirmationRow(),
        ),
        ToggleModeButton(),
      ],
    );
  }
}
