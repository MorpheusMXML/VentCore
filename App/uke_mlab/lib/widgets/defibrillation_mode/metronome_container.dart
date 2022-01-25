import 'package:flutter/material.dart';
import 'package:uke_mlab/utilities/app_theme.dart';
import 'package:uke_mlab/widgets/defibrillation_mode/metronome_switch.dart';

// TODO: COMMENTARY
class MetronomeContainer extends StatelessWidget {
  const MetronomeContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.all(8),
      color: theme.primarySwatch[40],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: const [
          Text("Metronome"),
          MetronomeSwitch(),
        ],
      ),
    );
  }
}
