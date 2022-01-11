import 'package:flutter/material.dart';
import 'package:uke_mlab/widgets/defibrillation_mode/synchronicity_button.dart';

class SyncContainer extends StatelessWidget {
  const SyncContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Row(
        children: const [
          SynchronicityButton.sync(),
          SynchronicityButton.async(),
        ],
      ),
    );
  }
}
