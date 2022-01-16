import 'package:flutter/material.dart';
import 'package:uke_mlab/utilities/enums/sensor.dart';
import 'package:uke_mlab/widgets/demo_screen/exit_button.dart';
import 'package:uke_mlab/widgets/value_box/value_box_tile.dart';

class AlarmLimitScreen extends StatelessWidget {
  const AlarmLimitScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 150,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: sensorEnumAbsolute.values
                .map((sensor) => ValueBoxTile(sensorAbsolute: sensor))
                .toList(),
          ),
        ),
        const Spacer(),
        // TODO: maybe new file?
        const ExitButton()
      ],
    );
  }
}
