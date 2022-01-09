import 'package:flutter/material.dart';
import 'package:uke_mlab/widgets/defibrillation_mode/defibrillation_button.dart';
import 'package:uke_mlab/widgets/defibrillation_mode/shock_power.dart';
import 'package:uke_mlab/widgets/defibrillation_mode/synchronicity_button.dart';
import 'package:uke_mlab/widgets/toggle/toggle_mode_button.dart';

class DefibrillationMode extends StatelessWidget {
  const DefibrillationMode({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          flex: 1,
          child: Row(
            children: const [
              DefibrillationButton.auto(),
              DefibrillationButton.manual(),
            ],
          ),
        ),
        const Flexible(
          flex: 1,
          child: ShockPower(),
        ),
        Flexible(
          flex: 1,
          child: Row(
            children: const [
              SynchronicityButton.sync(),
              SynchronicityButton.async(),
            ],
          ),
        ),
        const Spacer(flex: 2),
        ToggleModeButton(),
      ],
    );
  }
}
