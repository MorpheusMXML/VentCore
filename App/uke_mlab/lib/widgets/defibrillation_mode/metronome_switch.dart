import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/providers/defibrillation_controller.dart';

// TODO: COMMENTARY
class MetronomeSwitch extends StatelessWidget {
  const MetronomeSwitch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DefibrillationController defibrillationController =
        Get.find<DefibrillationController>();

    return Obx(
      () => Switch(
        value: defibrillationController.metronomeOn.value,
        onChanged: (changed) {
          defibrillationController.toggleMetronome(changed);
        },
      ),
    );
  }
}
