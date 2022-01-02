import 'package:flutter/material.dart';
import 'package:uke_mlab/widgets/toggle/toggle_mode_button.dart';

class DefibrillationMode extends StatelessWidget {
  const DefibrillationMode({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ToggleModeButton();
  }
}
