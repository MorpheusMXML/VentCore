import 'package:flutter/material.dart';
import 'package:uke_mlab/widgets/defibrillation_mode/metronome_switch.dart';

class MetronomeContainer extends StatelessWidget {
  const MetronomeContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: const [
        Text("Metronome"),
        MetronomeSwitch(),
      ],
    );
  }
}