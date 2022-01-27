import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/providers/defibrillation_controller.dart';
import 'package:uke_mlab/utilities/app_theme.dart';

/// Creates an a [Text] that displays the current system diagnosis.
///
/// The [DefibrillationController] handles all actions relating to this textfield.
///
/// {@category DefibrillationMode}
class SystemDiagnosis extends StatelessWidget {
  /// Displays current system diagnosis.

  /// Creates instance of [SystemDiagnosis].
  const SystemDiagnosis({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    DefibrillationController defibrillationController = Get.find<DefibrillationController>();

    return Container(
      color: theme.primarySwatch[70],
      margin: const EdgeInsets.all(8),
      child: Obx(
        () => Text(
          defibrillationController.systemDiagnosis.value,
          style: theme.defiDiagnosisTextStyle,
          softWrap: true,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
