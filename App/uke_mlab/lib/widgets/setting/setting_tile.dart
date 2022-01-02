import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/models/system_state.dart';
import 'package:uke_mlab/widgets/setting/decrement_button.dart';
import 'package:uke_mlab/widgets/setting/increment_button.dart';
import 'package:uke_mlab/widgets/setting/setting_text.dart';

class SettingTile extends StatelessWidget {
  final String name;
  final String rate;

  const SettingTile({
    Key? key,
    required this.name,
    required this.rate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF25232A),
      padding: const EdgeInsets.all(8),
      child: Container(
        color: const Color(0xFF2A2831),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SettingText(name: name, rate: rate),
            DecrementButton(name: name),
            IncrementButton(name: name)
          ],
        ),
      ),
    );
  }
}
