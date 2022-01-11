import 'package:flutter/material.dart';
import 'package:uke_mlab/widgets/defibrillation_mode/defibrillation_button.dart';

class DefibrillationContainer extends StatelessWidget {
  const DefibrillationContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Row(
        children: const [
          DefibrillationButton.auto(),
          DefibrillationButton.manual(),
        ],
      ),
    );
  }
}
