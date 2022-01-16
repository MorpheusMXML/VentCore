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
      child: Container(
        color: Theme.of(context).cardColor,
        margin: const EdgeInsets.all(8),
        child: Column(
          children: [
            Row(
              children: const [
                Expanded(
                    child: Text(
                  'Last Shock',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18),
                )),
                Expanded(
                    child: Text(
                  '# Shocks',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18),
                )),
                Expanded(
                    child: Text(
                  'Timer',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18),
                )),
              ],
            ),
            Row(
              children: [
                Expanded(
                    child: Obx(() =>
                        Text(defibrillationController.lastTimerString.value,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            )))),
                Expanded(
                    child: Obx(
                        () => Text('${defibrillationController.numberOfShocks}',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            )))),
                Expanded(
                    child: Obx(() =>
                        Text(defibrillationController.startTimerString.value,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            )))),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
