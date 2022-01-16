import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/providers/defibrillation_controller.dart';

class ShockPower extends StatelessWidget {
  const ShockPower({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DefibrillationController defibrillationController =
        Get.find<DefibrillationController>();

    return Flexible(
      child: Container(
        color: Theme.of(context).cardColor,
        margin: const EdgeInsets.only(left: 8, right: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Expanded(
              flex: 2,
              child: Text(
                "Shock Power",
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Obx(
                () => Text(
                  '${defibrillationController.shockPower}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 32,
                    color: Colors.red,
                  ),
                ),
              ),
            ),
            const Flexible(
              flex: 1,
              child: Text(
                "J",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.red,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
