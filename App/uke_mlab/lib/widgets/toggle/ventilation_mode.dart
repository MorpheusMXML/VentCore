import 'package:flutter/material.dart';
import 'package:uke_mlab/widgets/info/info_container.dart';
import 'package:uke_mlab/widgets/setting/setting_container.dart';
import 'package:uke_mlab/widgets/toggle/toggle_mode_button_container.dart';
import 'package:uke_mlab/widgets/value_box/alarm_confirmation/alarm_confirmation_button_row.dart';
import 'package:uke_mlab/widgets/value_box/value_box_tile.dart';
import 'package:uke_mlab/utilities/enums/sensor.dart';

/// Renders the [Widget] that structures the right part of the ventilation screen.
///
/// It Calls the Custom Widgets:
/// + [ValueBoxTile] for [sensorEnumAbsolute.breathfrequency], [sensorEnumAbsolute.mve] and [sensorEnumAbsolute.hfAbsolute]
/// + [SettingContainer] for IPPv-setting
/// + [InfoContainer]
/// + [AlarmConfirmationRow]
/// + [ToggleModeButtonContainer]
///
/// {@category Toggle}
class VentilationMode extends StatelessWidget {
  const VentilationMode({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Map<String, Object>> infoData = [
      {'type': 'pPeak', 'value': 50.12, 'unit': 'mBar'},
      {'type': 'pPlat', 'value': 4.58, 'unit': 'mBar'},
      {'type': 'pMean', 'value': 16.58, 'unit': 'mBar'},
      {'type': 'MV', 'value': 7.2, 'unit': 'l/min'}
    ];

    List<Map<String, String>> settingData = [
      {'name': 'Freq.', 'rate': '/min'},
      {'name': 'Vt', 'rate': 'ml'},
      {'name': 'PEEP', 'rate': 'mBar'},
    ];

    return Column(
      children: [
        Flexible(
          flex: 8,
          child: Row(
            children: const [
              Expanded(
                child: ValueBoxTile.withHeadline(sensorAbsolute: sensorEnumAbsolute.breathfrequency),
              ),
              Expanded(child: ValueBoxTile.withHeadline(sensorAbsolute: sensorEnumAbsolute.mve)),
            ],
          ),
        ),
        Flexible(
          flex: 8,
          child: Row(
            children: [
              Expanded(
                child: InfoContainer(data: infoData),
              ),
              const Expanded(
                child: ValueBoxTile.withHeadline(sensorAbsolute: sensorEnumAbsolute.hfAbsolute),
              ),
            ],
          ),
        ),
        Flexible(
          flex: 13,
          child: SettingContainer(data: settingData),
        ),
        const Flexible(
          flex: 3,
          child: AlarmConfirmationRow(),
        ),
        ToggleModeButtonContainer(),
      ],
    );
  }
}
