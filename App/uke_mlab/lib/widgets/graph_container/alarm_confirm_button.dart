import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/models/enums.dart';
import 'package:uke_mlab/models/system_state.dart';

class AlarmConfirmButton extends StatelessWidget {
  final sensorEnum sensor;
  const AlarmConfirmButton({
    Key? key,
    required this.sensor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SystemState systemState = Get.find<SystemState>();

    return ElevatedButton(
      onPressed: () =>
          systemState.violationStates[sensor] = boundaryStateEnum.suppressed,
      child: const Text("Confirm"),
    );
  }
}
