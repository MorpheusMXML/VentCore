import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/providers/defibrillation_controller.dart';
import 'package:uke_mlab/utilities/app_theme.dart';

// TODO: COMMENTARY
class DefibrillationButton extends StatelessWidget {
  final String name;
  const DefibrillationButton.auto({
    Key? key,
    this.name = 'Auto',
  }) : super(key: key);

  const DefibrillationButton.manual({
    Key? key,
    this.name = 'Manual',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final DefibrillationController defibrillationController =
        Get.find<DefibrillationController>();

    return Expanded(
      child: Container(
          margin: const EdgeInsets.all(8),
          child: Obx(() {
            return ElevatedButton(
              style: defibrillationController.selectedDefiButton.value != name
                  ? theme.defiRegularButtonStyle
                  : theme.defiSelectedButtonStyle,
              child: Text(name),
              onPressed: defibrillationController.selectedDefiButton.value !=
                      name
                  ? () => defibrillationController.setSelectedDefiButton(name)
                  : null,
            );
          })),
    );
  }
}
