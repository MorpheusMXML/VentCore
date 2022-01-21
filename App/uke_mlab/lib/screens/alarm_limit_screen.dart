import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/models/system_state.dart';
import 'package:uke_mlab/utilities/enums/sensor.dart';
import 'package:uke_mlab/widgets/demo_screen/exit_button.dart';
import 'package:uke_mlab/widgets/value_box/value_box_tile.dart';

class AlarmLimitScreen extends StatelessWidget {
  const AlarmLimitScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Set<sensorEnumAbsolute> graphBoundarySet = {};
    Set<sensorEnumAbsolute> monitorBoundarySet = {};
    Set<sensorEnumAbsolute> ventilationBoundarySet = {};

    for (var sensorKeyGraph in sensorEnumGraph.values) {
      sensorEnumAbsolute? sensorKey = SensorMapping.sensorMap[sensorKeyGraph];
      if (sensorKey != null) {
        graphBoundarySet.add(sensorKey);
      }
    }

    monitorBoundarySet
        .addAll(Get.find<SystemState>().absAlarmFieldModel.monitorSet);
    monitorBoundarySet
        .removeWhere((sensorKey) => graphBoundarySet.contains(sensorKey));

    ventilationBoundarySet
        .addAll(Get.find<SystemState>().absAlarmFieldModel.ventilationSet);
    ventilationBoundarySet
        .removeWhere((sensorKey) => graphBoundarySet.contains(sensorKey));

    return Row(
      children: [
        Flexible(
          flex: 5,
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 8, bottom: 4, left: 16),
                    child: const Text(
                      "Monitor Boundaries",
                      style: TextStyle(
                        fontSize: 24,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 16),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: Get.height / 4,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: monitorBoundarySet.map((sensorKey) {
                          return ValueBoxTile.withHeadline(
                              sensorAbsolute: sensorKey);
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),

              // Ventilation Boundaries
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 8, bottom: 4, left: 16),
                    child: const Text(
                      "Ventilation Boundaries",
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 16),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: Get.height / 4,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: ventilationBoundarySet.map((sensorKey) {
                          return ValueBoxTile.withHeadline(
                              sensorAbsolute: sensorKey);
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),

              // Ventilation Boundaries
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 8, bottom: 4, left: 16),
                    child: const Text(
                      "Graph Boundaries",
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 16),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: Get.height / 4,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: graphBoundarySet.map((sensorKey) {
                          return ValueBoxTile.withHeadline(
                              sensorAbsolute: sensorKey);
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        // Exit button at the bottom right
        //const Spacer(),
        Flexible(
          flex: 1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: const [
              Spacer(),
              // TODO: maybe new file?
              ExitButton()
            ],
          ),
        ),
      ],
    );
  }
}


// not well working graph boundaries with flexible GridView
/*
 Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Tile Boundaries
        Flexible(
          flex: 3,
          child: Column(
            children: [
              const Text(
                "Tile Boundaries",
                style: TextStyle(fontSize: 32),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Monitor Boundaries
                  Column(
                    children: [
                      const Text(
                        "Monitor Boundaries",
                        style: TextStyle(fontSize: 24),
                      ),
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          maxHeight: Get.height / 3.5,
                          maxWidth: Get.width * (2 / 3) - 10,
                        ),
                        child: Row(
                          children: monitorBoundarySet.map((sensorKey) {
                            return ValueBoxTile.withHeadline(
                                sensorAbsolute: sensorKey);
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                  // Ventilation Boundaries

                  Column(
                    children: [
                      const Text(
                        "Ventilation Boundaries",
                        style: TextStyle(fontSize: 24),
                      ),
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          maxHeight: Get.height / 3.5,
                          maxWidth: Get.width * (1 / 3) - 10,
                        ),
                        child: Row(
                          children: ventilationBoundarySet.map((sensorKey) {
                            return ValueBoxTile.withHeadline(
                                sensorAbsolute: sensorKey);
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),

        // Graph boundaries
        Flexible(
          flex: 3,
          child: Column(
            children: [
              const Text(
                "Graph Boundaries",
                style: TextStyle(fontSize: 32),
              ),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: Get.height / 3.5,
                  maxWidth: Get.width / 2 - 10,
                ),
                child: GridView.count(
                  crossAxisSpacing: 10,
                  shrinkWrap: true,
                  crossAxisCount: graphBoundarySet.length <= 5
                      ? graphBoundarySet.length
                      : (graphBoundarySet.length / 2).ceil(),
                  children: graphBoundarySet.map((sensorkey) {
                    return ValueBoxTile.withHeadline(sensorAbsolute: sensorkey);
                  }).toList(),
                ),
              )
            ],
          ),
        ),
*/

// Mudi old version:
/*
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
*/