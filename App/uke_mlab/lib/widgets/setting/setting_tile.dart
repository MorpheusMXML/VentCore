import 'package:flutter/material.dart';
import 'package:uke_mlab/widgets/setting/action_button.dart';
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
      color: Theme.of(context).focusColor,
      padding: const EdgeInsets.all(8),
      child: Container(
        color: Theme.of(context).cardColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SettingText(name: name, rate: rate),
            ActionButton.decrement(name: name),
            ActionButton.increment(name: name)
          ],
        ),
      ),
    );
  }
}
