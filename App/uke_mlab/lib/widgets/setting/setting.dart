import 'package:flutter/material.dart';
import 'package:uke_mlab/widgets/setting/setting_text.dart';

class Setting extends StatelessWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          flex: 1,
          child:
              ElevatedButton(onPressed: () {}, child: const Icon(Icons.remove)),
        ),
        const Flexible(flex: 2, child: SettingText()),
        Flexible(
          flex: 1,
          child: ElevatedButton(onPressed: () {}, child: const Icon(Icons.add)),
        ),
      ],
    );
  }
}
