import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/models/model_absolute.dart';
import 'package:uke_mlab/models/system_state.dart';

class AlarmButtonAbsoluteList extends StatelessWidget {
  const AlarmButtonAbsoluteList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemState systemState = Get.find<SystemState>();

    return Obx(
      () => ConstrainedBox(
        constraints: const BoxConstraints(
          maxHeight: 300,
          maxWidth: 500,
        ),
        child: Column(
          children: systemState.absAlarmFieldModel.ventilationSet.map((sensor) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(systemState.alarmState[sensor]!["message"]),
                ElevatedButton(
                  onPressed: () => {},
                  child: const Icon(Icons.check_circle_outline_rounded),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
