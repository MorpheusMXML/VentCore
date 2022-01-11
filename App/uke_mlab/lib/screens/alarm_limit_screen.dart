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
<<<<<<< HEAD
            mainAxisAlignment: MainAxisAlignment.center,
            children: sensorEnum.values
                .map((sensor) => ValueBoxTile(sensor: sensor))
                .toList(),
          ),
        ),
        const Spacer(),
        // TODO: maybe new file?
=======
              mainAxisAlignment: MainAxisAlignment.center,
              children: getBoxes()),
        ),
        // TODO: Display bottom right, maybe new file?
        const Spacer(),
>>>>>>> issue-94
        const ExitButton()
      ],
    );
  }
<<<<<<< HEAD
=======

  List<Widget> getBoxes() {
    List<Widget> widgets = [];

    for (var i = 0; i < sensorEnum.values.length; i++) {
      widgets.add(ValueBoxTile(sensor: sensorEnum.values[i]));
    }

    return widgets;
  }
>>>>>>> issue-94
}
