import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/models/system_state.dart';

class ActionButton extends StatelessWidget {
  final String name;
  final Icon icon;
  final int value;

  const ActionButton.increment({
    Key? key,
    required this.name,
    this.icon = const Icon(Icons.add),
    this.value = 1,
  }) : super(key: key);

  const ActionButton.decrement({
    Key? key,
    required this.name,
    this.icon = const Icon(Icons.remove),
    this.value = -1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final systemState = Get.find<SystemState>();

    return Flexible(
      child: ElevatedButton(
        onPressed: () => systemState.ippvModel.updateIPPVValue(name, value),
        child: icon,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          primary: const Color(0xFF5AC8FA),
        ),
      ),
    );
  }
}
