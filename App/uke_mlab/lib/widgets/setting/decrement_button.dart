import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/models/system_state.dart';

class DecrementButton extends StatelessWidget {
  final String name;
  const DecrementButton({
    Key? key,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final systemState = Get.find<SystemState>();

    return Flexible(
      child: ElevatedButton(
        onPressed: () => systemState.decrementIPPV(name),
        child: const Icon(
          Icons.remove,
        ),
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
