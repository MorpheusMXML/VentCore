import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/providers/defibrillation_controller.dart';
import 'package:uke_mlab/utilities/app_theme.dart';

/// Creates an Impedance Button with an intensity depending on which constructor is called.
/// [ImpedanceButton.low] creates an Impedance Button with low intensity.
/// [ImpedanceButton.medium] creates an Impedance Button with medium intensity.
/// [ImpedanceButton.high] creates an Impedance Button with high intensity.
///
/// The [DefibrillationController] handles all actions relating to this button.
class ImpedanceButton extends StatelessWidget {
  /// Impedance button for the defibrillation settings.

  final String name;

  /// Creates instance of [ImpedanceButton] with String 'Low'.
  const ImpedanceButton.low({
    Key? key,
    this.name = 'Low',
  }) : super(key: key);

  /// Creates instance of [ImpedanceButton] with String 'OK'.
  const ImpedanceButton.medium({
    Key? key,
    this.name = 'OK',
  }) : super(key: key);

  /// Creates instance of [ImpedanceButton] with String 'High'.
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
