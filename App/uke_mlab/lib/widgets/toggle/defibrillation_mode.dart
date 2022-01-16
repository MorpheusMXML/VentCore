import 'package:flutter/material.dart';
import 'package:uke_mlab/widgets/defibrillation_mode/defibrillation_container.dart';
import 'package:uke_mlab/widgets/defibrillation_mode/defibrillation_stats.dart';
import 'package:uke_mlab/widgets/defibrillation_mode/impedance_container.dart';
import 'package:uke_mlab/widgets/defibrillation_mode/load_button.dart';
import 'package:uke_mlab/widgets/defibrillation_mode/metronome_container.dart';
import 'package:uke_mlab/widgets/defibrillation_mode/shock_power.dart';
import 'package:uke_mlab/widgets/defibrillation_mode/sync_container.dart';
import 'package:uke_mlab/widgets/defibrillation_mode/system_diagnosis.dart';
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
          flex: 4,
          child: Container(
            width: MediaQuery.of(context).size.width / 3.5,
            margin: const EdgeInsets.only(top: 12),
            color: Theme.of(context).focusColor,
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
                      const LoadButton(),
                    ],
                  ),
                ),
                const DefibrillationStats(),
              ],
            ),
          ),
        ),
        const Spacer(),
        ToggleModeButton(),
      ],
    );
  }
}
