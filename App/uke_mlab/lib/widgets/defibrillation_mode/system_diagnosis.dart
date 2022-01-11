import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/providers/defibrillation_controller.dart';

class SystemDiagnosis extends StatelessWidget {
  const SystemDiagnosis({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DefibrillationController defibrillationController =
        Get.find<DefibrillationController>();

    return Flexible(
      child: Obx(
        () => Text(
          '${defibrillationController.systemDiagnosis}',
          style: const TextStyle(fontSize: 20),
          softWrap: true,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
