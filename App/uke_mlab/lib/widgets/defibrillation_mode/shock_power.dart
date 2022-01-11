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
          children: [
            const Expanded(
              flex: 3,
              child: Text(
                "Shock Power",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Obx(
                () => Text(
                  '${defibrillationController.shockPower}',
                  style: const TextStyle(
                    fontSize: 26,
                    color: Colors.red,
                  ),
                ),
              ),
            ),
            const Expanded(
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
