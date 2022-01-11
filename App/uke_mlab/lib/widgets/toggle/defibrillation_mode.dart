import 'package:flutter/material.dart';
import 'package:uke_mlab/widgets/defibrillation_mode/defibrillation_container.dart';
import 'package:uke_mlab/widgets/defibrillation_mode/impedance_container.dart';
import 'package:uke_mlab/widgets/defibrillation_mode/load_button.dart';
import 'package:uke_mlab/widgets/defibrillation_mode/metronome_container.dart';
import 'package:uke_mlab/widgets/defibrillation_mode/shock_power.dart';
import 'package:uke_mlab/widgets/defibrillation_mode/sync_container.dart';
import 'package:uke_mlab/widgets/toggle/toggle_mode_button.dart';

class DefibrillationMode extends StatelessWidget {
  const DefibrillationMode({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const DefibrillationContainer(),
        const ShockPower(),
        Flexible(
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
        ToggleModeButton(),
      ],
    );
  }
}
