import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/utilities/enums/sensor.dart';
import 'package:uke_mlab/models/system_state.dart';

class GraphAdderPopup extends StatelessWidget {
  final SystemState systemState = Get.find<SystemState>();

  GraphAdderPopup({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          fixedSize: const Size(800, 150),
          primary: Theme.of(context).cardColor.withOpacity(0.5),
        ),
        onPressed: () => systemState.addGraph.toggle(),
        child: Obx(
          () => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: sensorEnumGraph.values.map((sensor) {
                ButtonStyle style;
                systemState.graphList.contains(sensor)
                    ? style = ElevatedButton.styleFrom(
                        fixedSize: const Size(80, 60),
                        side: const BorderSide(width: 2, color: Colors.white),
                        primary: sensor.color,
                        onPrimary: Colors.white)
                    : style = ElevatedButton.styleFrom(
                        fixedSize: const Size(80, 60),
                        primary: Colors.grey[50],
                        onPrimary: Colors.black);

                return ElevatedButton(
                    style: style,
                    onPressed: () => systemState.graphList.contains(sensor)
                        ? systemState.graphList.remove(sensor)
                        : systemState.graphList.add(sensor),
                    child: Text(
                      sensor.graphTitle,
                      style: const TextStyle(fontSize: 18),
                      textAlign: TextAlign.center,
                    ));
              }).toList()),
        ));
  }
}
