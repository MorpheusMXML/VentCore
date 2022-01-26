import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/providers/screen_controller.dart';
import 'package:uke_mlab/utilities/app_theme.dart';
import 'package:uke_mlab/utilities/enums/sensor.dart';
import 'package:uke_mlab/models/system_state.dart';

/// This widget renders one [ElevatedButton] for each [sensorEnumGraph] on top of an [ElevatedButton].
/// Clicking the buttons for the [sensorEnumGraph] adds (or removes) it from the current list of graphs to be displayed.
/// Clicking the button underneath removes the sensor buttons so that only the [GraphAdder] is displayed.
///
/// {@category Graph}
class GraphAdderPopup extends StatelessWidget {
  /// Creates a popup to pick which graphs to display or remove.
  final SystemState systemState = Get.find<SystemState>();

  /// Creates instance of [GraphAdderPopup].
  GraphAdderPopup({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return ElevatedButton(
        style: theme.graphAdderPopupButtonStyle,
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
                    onPressed: () {
                      Get.find<ScreenController>().hideAlarmBoundaryOverlays();
                      systemState.graphList.list.contains(sensor)
                          ? systemState.graphList.graphListRemove(sensor)
                          : systemState.graphList.graphListAdd(sensor);
                    },
                    child: Text(
                      sensor.graphTitle,
                      style: theme.graphAdderPopupTextStyle,
                      textAlign: TextAlign.center,
                    ));
              }).toList()),
        ));
  }
}
