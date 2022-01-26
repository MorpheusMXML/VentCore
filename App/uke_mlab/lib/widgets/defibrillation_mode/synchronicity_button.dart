import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/providers/defibrillation_controller.dart';
import 'package:uke_mlab/utilities/app_theme.dart';

/// Creates an [SynchronicityButton] with the values "Sync" or "Async".
/// [SynchronicityButton.sync] creates a synchronized [SynchronicityButton].
/// [SynchronicityButton.async] creates an asynchronized [SynchronicityButton].
///
/// The [DefibrillationController] handles all actions relating to this button.
///
/// {@category DefibrillationMode}
class SynchronicityButton extends StatelessWidget {
  /// Synchronicity button for the defibrillation settings.
  final String name;

  /// Creates instance of [SynchronicityButton] with String 'Sync'.
  const SynchronicityButton.sync({
    Key? key,
    this.name = 'Sync',
  }) : super(key: key);

  /// Creates instance of [SynchronicityButton] with String 'Async'.
  const SynchronicityButton.async({
    Key? key,
    this.name = 'Async',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final DefibrillationController defibrillationController = Get.find<DefibrillationController>();

    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(8),
        child: Obx(
          () => ElevatedButton(
            style: defibrillationController.selectedSynchronicityButton.value != name
                ? theme.defiRegularButtonStyle
                : theme.defiSelectedButtonStyle,
            child: Text(name),
            onPressed: defibrillationController.selectedSynchronicityButton.value != name
                ? () => defibrillationController.setSelectedSynchronicityButton(name)
                : null,
          ),
        ),
      ),
    );
  }
}
