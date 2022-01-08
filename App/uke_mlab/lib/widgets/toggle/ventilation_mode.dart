import 'package:flutter/material.dart';
import 'package:uke_mlab/widgets/info/info_container.dart';
import 'package:uke_mlab/widgets/setting/setting_container.dart';
import 'package:uke_mlab/widgets/toggle/toggle_mode_button.dart';
import 'package:uke_mlab/widgets/value_box/value_box_tile.dart';
import 'package:uke_mlab/utilities/enums/sensor.dart';

class VentilationMode extends StatelessWidget {
  const VentilationMode({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: Move to a controller

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
          flex: 1,
          child: Row(
            children: const [
              ValueBoxTile.withHeadline(sensor: sensorEnum.mve),
              ValueBoxTile.withHeadline(sensor: sensorEnum.breathFrequency),
            ],
          ),
        ),
        Flexible(
          flex: 1,
          child: Row(
            children: [
              Expanded(child: InfoContainer(data: infoData)),
              const ValueBoxTile.withHeadline(sensor: sensorEnum.breathFrequency),
            ],
          ),
        ),
        Flexible(
          flex: 2,
          child: SettingContainer(data: settingData),
        ),
        ToggleModeButton(),
      ],
    );
  }
}
