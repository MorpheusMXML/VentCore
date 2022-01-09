import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/utilities/enums/sensor.dart';
import 'package:uke_mlab/utilities/enums/boundary_state.dart';
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
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(75),
        ),
        fixedSize: const Size(70, 70),
        primary: Theme.of(context).shadowColor,
        onPrimary: Theme.of(context).dividerColor,
      ),
      onPressed: () =>
          systemState.violationStates[sensor] = boundaryStateEnum.suppressed,
      child: const Icon(Icons.check),
    );
  }
}
