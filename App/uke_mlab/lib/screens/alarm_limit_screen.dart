import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/utilities/enums/sensor.dart';
import 'package:uke_mlab/widgets/demo_screen/exit_button.dart';
import 'package:uke_mlab/widgets/value_box/value_box_tile.dart';

class AlarmLimitScreen extends StatelessWidget {
  const AlarmLimitScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(child: Container()),
        Flexible(
          flex: 3,
          child: Column(
            children: [
              const Text('Monitoring', style: TextStyle(fontSize: 32)),
              GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  children: [
                    sensorEnumAbsolute.hfAbsolute,
                    sensorEnumAbsolute.spo2Absolute,
                    sensorEnumAbsolute.tempAbsolute,
                    sensorEnumAbsolute.sysAbsolute,
                    sensorEnumAbsolute.co2Absolute,
                    sensorEnumAbsolute.diaAbsolute,
                    sensorEnumAbsolute.pulse,
                  ]
                      .map((sensor) =>
                          ValueBoxTile.withHeadline(sensorAbsolute: sensor))
                      .toList()),
            ],
          ),
        ),
        Flexible(child: Container()),
        Flexible(
          flex: 3,
          child: Column(
            children: [
              const Text('Ventilation', style: TextStyle(fontSize: 32)),
              GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  children: [
                    sensorEnumAbsolute.hfAbsolute,
                    sensorEnumAbsolute.mve,
                    sensorEnumAbsolute.breathfrequency,
                  ]
                      .map((sensor) =>
                          ValueBoxTile.withHeadline(sensorAbsolute: sensor))
                      .toList()),
            ],
          ),
        ),
        Flexible(flex: 4, child: Container())
      ],
    );
  }
}

/*
  const Spacer(),
  // TODO: maybe new file?
  const ExitButton()
*/