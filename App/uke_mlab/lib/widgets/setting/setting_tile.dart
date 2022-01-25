import 'package:flutter/material.dart';
import 'package:uke_mlab/utilities/app_theme.dart';
import 'package:uke_mlab/widgets/setting/action_button.dart';
import 'package:uke_mlab/widgets/setting/setting_text.dart';

// TODO: COMMENTARY
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
    final ThemeData theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(8),
      child: Container(
        color: theme.primarySwatch[40],
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ActionButton.decrement(name: name),
            SettingText(name: name, rate: rate),
            ActionButton.increment(name: name),
          ],
        ),
      ),
    );
  }
}
