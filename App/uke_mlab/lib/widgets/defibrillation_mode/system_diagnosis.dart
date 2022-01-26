import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/providers/defibrillation_controller.dart';
import 'package:uke_mlab/utilities/app_theme.dart';

// TODO: COMMENTARY
class SystemDiagnosis extends StatelessWidget {
  const SystemDiagnosis({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    DefibrillationController defibrillationController =
        Get.find<DefibrillationController>();

    return Container(
      color: theme.primarySwatch[40],
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
