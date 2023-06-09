import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/providers/defibrillation_controller.dart';
import 'package:uke_mlab/utilities/app_theme.dart';

/// Creates an auto or manual button depending on which constructor is called for the defibrillation settings.
///
/// [DefibrillationButton.auto] creates an Auto Button.
/// [DefibrillationButton.manual] creates a Manual Button.
///
/// The [DefibrillationController] handles all actions relating to this button.
///
/// {@category DefibrilationMode}
class DefibrillationButton extends StatelessWidget {
  /// Auto/Manual Button for the defibrillation settings.
  final String name;

  /// Creates instance of [DefibrillationButton] with String 'Auto'.
  const DefibrillationButton.auto({
    Key? key,
    this.name = 'Auto',
  }) : super(key: key);

  /// Creates instance of [DefibrillationButton] with String 'Manual'.
  const DefibrillationButton.manual({
    Key? key,
    this.name = 'Manual',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final DefibrillationController defibrillationController = Get.find<DefibrillationController>();

    return Expanded(
      child: Container(
          margin: const EdgeInsets.all(8),
          child: Obx(() {
            return ElevatedButton(
              style: defibrillationController.selectedDefiButton.value != name
                  ? theme.defiRegularButtonStyle
                  : theme.defiSelectedButtonStyle,
              child: Text(name),
              onPressed: defibrillationController.selectedDefiButton.value != name
                  ? () => defibrillationController.setSelectedDefiButton(name)
                  : null,
            );
          })),
    );
  }
}
