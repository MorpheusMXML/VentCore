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
            children: [
              // ValueBoxTile.withHeadline(sensor: sensorEnumNibd.nibd), // TODO requires multiple constructors in  ValueBoxTile to display special elements
              Container(),
              // ValueBoxTile.withHeadline(sensor: sensorEnumAbsolute.pulse), // TODO requires pulse value in sensorEnumAbsolute
              Container(),
            ],
          ),
        ),
        Flexible(
          flex: 1,
          child: Row(
            children: [
              Container(),
              //ValueBoxTile.withHeadline(sensor: sensorEnumAbsolute.mve), // TODO requires mve value in sensorEnumAbsolute
              const ValueBoxTile.withHeadline(
                  sensorAbsolute:
                      sensorEnumAbsolute.hfAbsolute), //TODO BreathFreq here?
            ],
          ),
        ),
        const Spacer(flex: 2),
        ToggleModeButton(),
      ],
    );
  }
}
