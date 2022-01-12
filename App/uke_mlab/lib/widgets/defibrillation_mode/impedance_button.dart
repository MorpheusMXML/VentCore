import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/providers/defibrillation_controller.dart';

class ImpedanceButton extends StatelessWidget {
  final String name;
  const ImpedanceButton.low({
    Key? key,
    this.name = 'Low',
  }) : super(key: key);

  const ImpedanceButton.medium({
    Key? key,
    this.name = 'OK',
  }) : super(key: key);

  const ImpedanceButton.high({
    Key? key,
    this.name = 'High',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DefibrillationController defibrillationController =
        Get.find<DefibrillationController>();

    return Expanded(
      child: Container(
          margin: const EdgeInsets.all(2),
          child: Obx(() {
            ButtonStyle buttonStyle;
            defibrillationController.selectedImpedanceButton.value != name
                ? buttonStyle = ElevatedButton.styleFrom(
                    primary: Theme.of(context).cardColor,
                    onPrimary: Theme.of(context).dividerColor)
                : buttonStyle = ButtonStyle(
                    side: MaterialStateProperty.all(
                        const BorderSide(color: Colors.green)),
                    foregroundColor: MaterialStateProperty.all(Colors.green),
                  );
            return ElevatedButton(
              style: buttonStyle,
              child: Text(name, style: const TextStyle(fontSize: 12)),
              onPressed:
                  defibrillationController.selectedImpedanceButton.value != name
                      ? () => defibrillationController
                          .setSelectedImpedanceButton(name)
                      : null,
            );
          })),
    );
  }
}
