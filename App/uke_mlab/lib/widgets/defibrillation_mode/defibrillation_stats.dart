import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/providers/defibrillation_controller.dart';

class DefibrillationStats extends StatelessWidget {
  const DefibrillationStats({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DefibrillationController defibrillationController =
        Get.find<DefibrillationController>();

    defibrillationController.startTimerWatch();

    return Flexible(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              Text('last'),
              Text('# Shocks'),
              Text('Timer'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Obx(() => Text(defibrillationController.lastTimerString.value)),
              Obx(() => Text('${defibrillationController.numberOfShocks}')),
              Obx(
                () => Text(defibrillationController.startTimerString.value),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
