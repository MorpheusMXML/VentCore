import 'package:flutter/material.dart';

class Bell extends StatelessWidget {
  const Bell({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        primary: Colors.grey[800],
        fixedSize: const Size(80, 80),
        shape: const CircleBorder(),
      ),
      child: const Icon(Icons.notifications, size: 40),
    );
  }
}
