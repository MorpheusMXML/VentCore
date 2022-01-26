import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/models/system_state.dart';
import 'package:uke_mlab/utilities/app_theme.dart';
import 'package:uke_mlab/utilities/enums/sensor.dart';
import 'package:uke_mlab/widgets/demo_screen/exit_button.dart';
import 'package:uke_mlab/widgets/value_box/value_box_tile.dart';

/// Presents all data models and the ability to adjust their boundaries via [ValueBoxTile]s
/// {@category Screens}
class AlarmLimitScreen extends StatelessWidget {
  const AlarmLimitScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    Set<sensorEnumAbsolute> graphBoundarySet = {};
    Set<sensorEnumAbsolute> monitorBoundarySet = {};
    Set<sensorEnumAbsolute> ventilationBoundarySet = {};

    for (var sensorKeyGraph in sensorEnumGraph.values) {
      sensorEnumAbsolute? sensorKey = SensorMapping.sensorMap[sensorKeyGraph];
      if (sensorKey != null) {
        graphBoundarySet.add(sensorKey);
      }
    }

    monitorBoundarySet.addAll(Get.find<SystemState>().absAlarmFieldModel.monitorSet);
    monitorBoundarySet.removeWhere((sensorKey) => graphBoundarySet.contains(sensorKey));

    ventilationBoundarySet.addAll(Get.find<SystemState>().absAlarmFieldModel.ventilationSet);
    ventilationBoundarySet.removeWhere((sensorKey) => graphBoundarySet.contains(sensorKey));

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
                    child: Text(
                      "Monitor Boundaries",
                      style: theme.mediumTextStyle,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: monitorBoundarySet.map((sensorKey) {
                        return SizedBox(
                          height: 180,
                          width: (Get.width - 24) / 3 / 2 + 15,
                          child: ValueBoxTile.withHeadline(sensorAbsolute: sensorKey),
                        );
                      }).toList(),
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
                    child: Text(
                      "Ventilation Boundaries",
                      style: theme.mediumTextStyle,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: ventilationBoundarySet.map((sensorKey) {
                        return SizedBox(
                          height: 180,
                          width: (Get.width - 24) / 3 / 2 + 15,
                          child: ValueBoxTile.withHeadline(sensorAbsolute: sensorKey),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),

              // Graph Boundaries
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 8, bottom: 4, left: 16),
                    child: Text(
                      "Graph Boundaries",
                      style: theme.mediumTextStyle,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: graphBoundarySet.map((sensorKey) {
                        return SizedBox(
                          height: 180,
                          width: (Get.width - 24) / 3 / 2 + 15,
                          child: ValueBoxTile.withHeadline(sensorAbsolute: sensorKey),
                        );
                      }).toList(),
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
              ExitButton(),
            ],
          ),
        ),
      ],
    );
  }
}
