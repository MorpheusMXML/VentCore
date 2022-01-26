import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/providers/defibrillation_controller.dart';
import 'package:uke_mlab/utilities/app_theme.dart';

// TODO: COMMENTARY
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
    final ThemeData theme = Theme.of(context);
    final DefibrillationController defibrillationController =
        Get.find<DefibrillationController>();

    return Expanded(
      child: Container(
          margin: const EdgeInsets.all(2),
          child: Obx(() {
            return ElevatedButton(
              style:
                  defibrillationController.selectedImpedanceButton.value != name
                      ? theme.defiRegularButtonStyle
                      : theme.defiSelectedButtonStyle,
              child: Text(name),
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
