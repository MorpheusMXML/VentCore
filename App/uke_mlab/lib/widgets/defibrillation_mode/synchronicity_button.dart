import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/providers/defibrillation_controller.dart';
import 'package:uke_mlab/utilities/app_theme.dart';

// TODO: COMMENTARY
class SynchronicityButton extends StatelessWidget {
  final String name;
  const SynchronicityButton.sync({
    Key? key,
    this.name = 'Sync',
  }) : super(key: key);

  const SynchronicityButton.async({
    Key? key,
    this.name = 'Async',
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
            ButtonStyle buttonStyle;
            defibrillationController.selectedSynchronicityButton.value != name
                ? buttonStyle = ElevatedButton.styleFrom(
                    primary: theme.primarySwatch[40],
                    onPrimary: theme.contrastColor,
                  )
                : buttonStyle = ButtonStyle(
                    side: MaterialStateProperty.all(
                        const BorderSide(color: Colors.green)),
                    foregroundColor: MaterialStateProperty.all(Colors.green),
                  );
            return ElevatedButton(
              style: buttonStyle,
              child: Text(name),
              onPressed:
                  defibrillationController.selectedSynchronicityButton.value !=
                          name
                      ? () => defibrillationController
                          .setSelectedSynchronicityButton(name)
                      : null,
            );
          })),
    );
  }
}
