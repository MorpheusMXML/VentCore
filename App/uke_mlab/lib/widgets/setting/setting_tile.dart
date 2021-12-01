import 'package:flutter/material.dart';
import 'package:uke_mlab/widgets/setting/setting.dart';

class SettingTile extends StatelessWidget {
  const SettingTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          child: const Text("IPPV"),
          onPressed: () {},
        ),
        const Setting(),
        const Setting(),
        const Setting(),
      ],
    );
  }
}
