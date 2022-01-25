import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/providers/defibrillation_controller.dart';

// TODO: COMMENTARY
class SystemDiagnosis extends StatelessWidget {
  const SystemDiagnosis({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DefibrillationController defibrillationController =
        Get.find<DefibrillationController>();

    return Container(
      color: Theme.of(context).cardColor,
      margin: const EdgeInsets.all(8),
      child: Obx(
        () => Text(
          defibrillationController.systemDiagnosis.value,
          style: const TextStyle(fontSize: 20),
          softWrap: true,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
