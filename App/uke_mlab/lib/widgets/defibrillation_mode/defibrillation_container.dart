import 'package:flutter/material.dart';
import 'package:uke_mlab/widgets/defibrillation_mode/defibrillation_button.dart';

/// Creates a row of the two possible [DefibrillationButton]s,  [DefibrillationButton.auto] and [DefibrillationButton.manual].
///
/// The row is displayed by [DefibrillationMode].
///
/// {@category DefibrillationMode}
class DefibrillationContainer extends StatelessWidget {
  /// The two defibrillation buttons, auto and manual.

  /// Creates instance of [DefibrillationContainer].
  const DefibrillationContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Row(
        children: const [
          DefibrillationButton.auto(),
          DefibrillationButton.manual(),
        ],
      ),
    );
  }
}
