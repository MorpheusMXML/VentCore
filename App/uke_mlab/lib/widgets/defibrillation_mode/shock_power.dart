import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/providers/defibrillation_controller.dart';

// TODO: COMMENTARY
class ShockPower extends StatelessWidget {
  const ShockPower({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DefibrillationController defibrillationController = Get.find<DefibrillationController>();

    return Flexible(
      child: Container(
        color: Theme.of(context).cardColor,
        margin: const EdgeInsets.only(left: 8, right: 8),
        child: Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: defibrillationController.shockClicked.value
                ? [
                    Expanded(
                      flex: 3,
                      child: Obx(
                        () => defibrillationController.shockClicked.value
                            ? Slider(
                                label: defibrillationController.shockPower.value.toString(),
                                min: 0,
                                max: 250,
                                divisions: 10,
                                onChangeEnd: (value) => defibrillationController.shockClicked.toggle(),
                                onChanged: (newValue) => defibrillationController.shockPower.value = newValue.toInt(),
                                value: defibrillationController.shockPower.value.toDouble(),
                              )
                            : ElevatedButton(
                                style: ElevatedButton.styleFrom(primary: Colors.transparent),
                                child: Text(
                                  '${defibrillationController.shockPower}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 32,
                                    color: Colors.red,
                                  ),
                                ),
                                onPressed: () => defibrillationController.shockClicked.toggle(),
                              ),
                      ),
                    ),
                  ]
                : [
                    const Expanded(
                      flex: 3,
                      child: Text(
                        "Shock Power",
                        style: TextStyle(
                          fontSize: 24,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Colors.transparent),
                        child: Text(
                          '${defibrillationController.shockPower}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 32,
                            color: Colors.red,
                          ),
                        ),
                        onPressed: () => defibrillationController.shockClicked.toggle(),
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
      ),
    );
  }
}
