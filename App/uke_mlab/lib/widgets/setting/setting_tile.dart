import 'package:flutter/material.dart';
import 'package:uke_mlab/widgets/setting/setting.dart';

class SettingTile extends StatelessWidget {
  const SettingTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            primary: const Color(0xFF5AC8FA),
          ),
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
