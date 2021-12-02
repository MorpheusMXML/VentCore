import 'package:flutter/material.dart';

class SettingText extends StatelessWidget {
  const SettingText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const Text(
        "Freq",
        style: TextStyle(fontSize: 16, color: Colors.white),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text("12", style: TextStyle(fontSize: 32, color: Colors.white)),
          Text("/min", style: TextStyle(fontSize: 16, color: Colors.white)),
        ],
      )
    ]);
  }
}
