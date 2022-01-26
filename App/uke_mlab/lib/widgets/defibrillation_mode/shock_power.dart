import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/providers/defibrillation_controller.dart';
import 'package:uke_mlab/utilities/app_theme.dart';

/// Displays the shock power for the defibrillation in joule.
/// If clicked on the shock power value, widget renders into a [Slider] for adjusting the shock power.
///
/// The [DefibrillationController] handles all actions relating to the button and switch.
///
/// {@category DefibrillationMode}
class ShockPower extends StatelessWidget {
  /// Displays all widgets related to the shock power.

  /// Creates instance of [ShockPower].
  const ShockPower({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    DefibrillationController defibrillationController = Get.find<DefibrillationController>();

    return Flexible(
      child: Container(
        color: theme.primarySwatch[40],
        margin: const EdgeInsets.only(left: 8, right: 8),
        child: Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: defibrillationController.shockClicked.value
                ? [
                    Expanded(
                      child: Slider(
                        label: defibrillationController.shockPower.value.toString(),
                        min: 0,
                        max: 250,
                        divisions: 10,
                        onChangeEnd: (value) => defibrillationController.shockClicked.toggle(),
                        onChanged: (newValue) => defibrillationController.shockPower.value = newValue.toInt(),
                        value: defibrillationController.shockPower.value.toDouble(),
                      ),
                    )
                  ]
                : [
                    Expanded(
                      flex: 3,
                      child: Text(
                        "Shock Power",
                        style: theme.shockPowerTextStyle,
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: ElevatedButton(
                        style: theme.shockPowerButtonStyle,
                        child: Text(
                          '${defibrillationController.shockPower}',
                          style: theme.shockPowerButtonTextStyle,
                        ),
                        onPressed: () => defibrillationController.shockClicked.toggle(),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Text(
                        "J",
                        style: theme.jouleTextStyle,
                      ),
                    )
                  ],
          ),
        ),
      ),
    );
  }
}
