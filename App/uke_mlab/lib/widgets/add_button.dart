import 'package:flutter/material.dart';
import 'package:uke_mlab/providers/mockup.dart';

class AddButton extends StatelessWidget {
  final MonitorController controller;

  const AddButton({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => controller.invert(),
      style: ElevatedButton.styleFrom(
        primary: Colors.grey[800],
        fixedSize: const Size(80, 80),
        shape: const CircleBorder(),
      ),
      child: const Icon(Icons.add, size: 40),
    );
  }
}
