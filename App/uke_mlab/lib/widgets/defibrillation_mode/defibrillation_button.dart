import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/providers/defibrillation_controller.dart';

class DefibrillationButton extends StatelessWidget {
  final String name;
  const DefibrillationButton.auto({
    Key? key,
    this.name = 'Auto',
  }) : super(key: key);

  const DefibrillationButton.manual({
    Key? key,
    this.name = 'Manual',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DefibrillationController defibrillationController =
        Get.find<DefibrillationController>();

    return Expanded(
      child: Container(
          margin: const EdgeInsets.all(8),
          child: Obx(() {
            ButtonStyle buttonStyle;
            defibrillationController.selectedDefiButton.value != name
                ? buttonStyle = ElevatedButton.styleFrom(
                    primary: Theme.of(context).cardColor,
                    onPrimary: Theme.of(context).dividerColor)
                : buttonStyle = ButtonStyle(
                    side: MaterialStateProperty.all(
                        const BorderSide(color: Colors.green)),
                    foregroundColor: MaterialStateProperty.all(Colors.green),
                  );
            return ElevatedButton(
              style: buttonStyle,
              child: Text(name),
              onPressed: defibrillationController.selectedDefiButton.value != name
                  ? () => defibrillationController.setSelectedDefiButton(name)
                  : null,
            );
          })),
    );
  }
}
