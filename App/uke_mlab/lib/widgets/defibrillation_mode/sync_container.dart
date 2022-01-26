import 'package:flutter/material.dart';
import 'package:uke_mlab/widgets/defibrillation_mode/synchronicity_button.dart';

/// Creates a flexible row of the two possible [SynchronicityButton]s,  [SynchronicityButton.sync] and [SynchronicityButton.sync].

/// {@category DefibrillationMode}
class SyncContainer extends StatelessWidget {
  /// Displays all synchronicity related widgets.

  /// Creates instance of [SyncContainer].
  const SyncContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Row(
        children: const [
          SynchronicityButton.sync(),
          SynchronicityButton.async(),
        ],
      ),
    );
  }
}
