import 'package:flutter/material.dart';
import 'package:uke_mlab/utilities/app_theme.dart';
import 'package:uke_mlab/widgets/defibrillation_mode/defibrillation_container.dart';
import 'package:uke_mlab/widgets/defibrillation_mode/defibrillation_stats.dart';
import 'package:uke_mlab/widgets/defibrillation_mode/impedance_container.dart';
import 'package:uke_mlab/widgets/defibrillation_mode/load_shock_button.dart';
import 'package:uke_mlab/widgets/defibrillation_mode/metronome_container.dart';
import 'package:uke_mlab/widgets/defibrillation_mode/shock_power.dart';
import 'package:uke_mlab/widgets/defibrillation_mode/sync_container.dart';
import 'package:uke_mlab/widgets/defibrillation_mode/system_diagnosis.dart';
import 'package:uke_mlab/widgets/toggle/toggle_mode_button_container.dart';

/// This Class Renders the [Widget] that Structures the Defibrillation Screen.
///
/// It Calls the Custom Widgets:
/// + [SystemDiagnosis]
/// + [DefibrillationContainer]
/// + [ShockPower]
/// + [MetronomeContainer]
/// + [ImpedanceContainer]
/// + [SyncContainer]
/// + [LoadShockButton]
/// + [DefibrillationStats]
///
/// These Widgets Display the different Settings and Information needed for the Defibrillation.
///
/// {@category Toggle}
class DefibrillationMode extends StatelessWidget {
  const DefibrillationMode({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Column(
      children: [
        Flexible(
          flex: 4,
          child: Container(
            width: MediaQuery.of(context).size.width / 3.5,
            margin: const EdgeInsets.only(top: 12),
            color: theme.primarySwatch[50],
            child: Column(
              children: [
                const SystemDiagnosis(),
                const DefibrillationContainer(),
                const ShockPower(),
                Flexible(
                  flex: 3,
                  child: Row(
                    children: [
                      Flexible(
                        child: Column(children: const [
                          MetronomeContainer(),
                          ImpedanceContainer(),
                          SyncContainer(),
                        ]),
                      ),
                      const LoadShockButton(),
                    ],
                  ),
                ),
                const DefibrillationStats(),
              ],
            ),
          ),
        ),
        const Spacer(),
        const ToggleModeButtonContainer(),
      ],
    );
  }
}
