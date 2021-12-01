import 'package:flutter/material.dart';
import 'package:uke_mlab/widgets/setting_text.dart';

class Setting extends StatelessWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ElevatedButton(
          onPressed: () {},
          child: Text("-"),
        ),
        SettingText(),
        ElevatedButton(
          onPressed: () {},
          child: Text("+"),
        ),
      ],
    );
  }
}
