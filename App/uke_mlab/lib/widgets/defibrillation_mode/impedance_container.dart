import 'package:flutter/material.dart';
import 'package:uke_mlab/widgets/defibrillation_mode/impedance_button.dart';

class ImpedanceContainer extends StatelessWidget {
  const ImpedanceContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Impedance",
          style: TextStyle(color: Theme.of(context).dividerColor),
        ),
        Row(
          children: const [
            ImpedanceButton.low(),
            ImpedanceButton.medium(),
            ImpedanceButton.high(),
          ],
        )
      ],
    );
  }
}
