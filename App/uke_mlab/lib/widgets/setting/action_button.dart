import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/models/system_state.dart';
import 'package:uke_mlab/utilities/app_theme.dart';

/// Button to increment or decrement a respective IPPv-field
class ActionButton extends StatelessWidget {
  /// Name of the IPPv-field, can be 'Freq.', 'Vt' or 'PEEP'
  final String name;

  /// The icon to be displayed (prefered add or delete associated depending on constructor)
  final Icon icon;

  /// The orientation of the change
  final int value;

  /// Button if incrementation behavior is wanted
  const ActionButton.increment({
    Key? key,
    required this.name,
    this.icon = const Icon(Icons.add),
    this.value = 1,
  }) : super(key: key);

  /// Button if incrementation behavior is wanted
  const ActionButton.decrement({
    Key? key,
    required this.name,
    this.icon = const Icon(Icons.remove),
    this.value = -1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final systemState = Get.find<SystemState>();

    return Flexible(
      child: ElevatedButton(
        onPressed: () => systemState.ippvModel.updateIPPVValue(name, value),
        child: icon,
        style: theme.actionButtonStyle,
      ),
    );
  }
}
