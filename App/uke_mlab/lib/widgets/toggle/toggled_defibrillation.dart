import 'package:flutter/material.dart';
import 'package:uke_mlab/widgets/toggle/mode_toggle_button.dart';

class ToggledDefibrillation extends StatelessWidget {
  const ToggledDefibrillation({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ModeToggleButton();
  }
}
