import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/utilities/app_theme.dart';
import 'package:uke_mlab/utilities/enums/sensor.dart';
import 'package:uke_mlab/models/system_state.dart';

// TODO: COMMENTARY
class GraphAdderPopup extends StatelessWidget {
  final SystemState systemState = Get.find<SystemState>();

  GraphAdderPopup({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          fixedSize: const Size(800, 150),
          primary: theme.primarySwatch[40]!.withOpacity(0.5),
        ),
        onPressed: () => systemState.graphList.addGraph.toggle(),
        child: Obx(
          () => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: sensorEnumGraph.values.map((sensor) {
                ButtonStyle style;
                systemState.graphList.list.contains(sensor)
                    ? style = ElevatedButton.styleFrom(
                        fixedSize: const Size(80, 60),
                        side: const BorderSide(width: 2, color: Colors.white),
                        primary: sensor.color,
                        onPrimary: Colors.white)
                    : style = ElevatedButton.styleFrom(
                        fixedSize: const Size(80, 60),
                        primary: Colors.grey[50],
                        onPrimary: theme.inverseContrastColor);

                return ElevatedButton(
                    style: style,
                    onPressed: () => systemState.graphList.list.contains(sensor)
                        ? systemState.graphList.graphListRemove(sensor)
                        : systemState.graphList.graphListAdd(sensor),
                    child: Text(
                      sensor.graphTitle,
                      style: const TextStyle(fontSize: 18),
                      textAlign: TextAlign.center,
                    ));
              }).toList()),
        ));
  }
}
