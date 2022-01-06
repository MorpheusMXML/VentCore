import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/models/enums.dart';
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
          primary: const Color(0xFF2A2831).withOpacity(0.5),
        ),
        onPressed: () => systemState.addGraph.toggle(),
        child: Obx(
          () => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: sensorEnum.values.map((sensor) {
                ButtonStyle style;
                systemState.graphList.contains(sensor)
                    ? style = ElevatedButton.styleFrom(
                        fixedSize: const Size(80, 60),
                        // TODO: load color from sensors json or model manager?
                        primary: Colors.green,
                        onPrimary: Colors.black)
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
                      sensor.displayString,
                      style: const TextStyle(fontSize: 18),
                      textAlign: TextAlign.center,
                    ));
              }).toList()),
        ));
  }
}
