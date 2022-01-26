import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/providers/defibrillation_controller.dart';

/// Creates an on/off switch for enabling/disabling the metronome.
///
/// The [DefibrillationController] handles all actions relating to this switch.
class MetronomeSwitch extends StatelessWidget {
  /// The toggling switch for the metronome.

  /// Creates instance of [MetronomeSwitch] with String 'Low'.
  const MetronomeSwitch({
    Key? key,
  }) : super(key: key);

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
