import 'package:flutter/material.dart';

class SettingText extends StatelessWidget {
  const SettingText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const Text(
        "1",
        style: TextStyle(fontSize: 16, color: Colors.white),
      ),
      Row(
        children: const [
          Text(
            "1",
            style: TextStyle(fontSize: 32, color: Colors.white),
          ),
          Text("2", style: TextStyle(fontSize: 16, color: Colors.white))
        ],
      )
    ]);
  }
}
