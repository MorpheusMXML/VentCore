import 'package:flutter/material.dart';
import 'package:uke_mlab/utilities/app_theme.dart';
import 'package:uke_mlab/widgets/defibrillation_mode/impedance_button.dart';

// TODO: COMMENTARY
class ImpedanceContainer extends StatelessWidget {
  const ImpedanceContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Container(
      color: theme.primarySwatch[40],
      margin: const EdgeInsets.all(6),
      child: Column(
        children: [
          Text(
            "Impedance",
            style: theme.impedanceTextStyle,
          ),
          Row(
            children: const [
              ImpedanceButton.low(),
              ImpedanceButton.medium(),
              ImpedanceButton.high(),
            ],
          )
        ],
      ),
    );
  }
}
