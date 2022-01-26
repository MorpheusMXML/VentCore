import 'package:flutter/material.dart';
import 'package:uke_mlab/widgets/toggle/toggle_mode_button.dart';
import 'package:uke_mlab/widgets/value_box/alarm_confirmation/alarm_confirmation_button_row.dart';
import 'package:uke_mlab/widgets/value_box/value_box_tile.dart';
import 'package:uke_mlab/utilities/enums/sensor.dart';
import 'package:uke_mlab/widgets/value_box/value_box_tile_nibd.dart';

class MonitoringMode extends StatelessWidget {
  /// This Class Renders the [Widget] that structures the right part of the monitoring screen.
  ///
  /// It Calls the Custom Widgets:
  /// + [ValueBoxTile] for [sensorEnumAbsolute.pulse] and [sensorEnumAbsolute.tempAbsolute]
  /// + [ValueBoxTileNIBD]
  /// + [AlarmConfirmationRow]
  /// + [ToggleModeButton]
  const MonitoringMode({
    Key? key,
    absoluteValueBoxTiles,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          flex: 8,
          child: Row(
            children: const [
              Expanded(
                child: ValueBoxTile.withHeadline(
                    sensorAbsolute: sensorEnumAbsolute.pulse),
              ),
              Expanded(
                child: ValueBoxTile.withHeadline(
                    sensorAbsolute: sensorEnumAbsolute.tempAbsolute),
              ),
            ],
          ),
        ),
        Flexible(
          flex: 8,
          child: Row(
            children: const [
              Expanded(
                child: ValueBoxTileNIBD(
                  sensorAbsoluteDIA: sensorEnumAbsolute.diaAbsolute,
                  sensorAbsoluteSYS: sensorEnumAbsolute.sysAbsolute,
                ),
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
