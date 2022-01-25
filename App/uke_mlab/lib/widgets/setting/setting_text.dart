import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/models/system_state.dart';
import 'package:uke_mlab/utilities/app_theme.dart';

// TODO: COMMENTARY
class SettingText extends StatelessWidget {
  final String name;
  final String rate;
  const SettingText({
    Key? key,
    required this.name,
    required this.rate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final systemState = Get.find<SystemState>();

    return Flexible(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment:
            CrossAxisAlignment.baseline, //gets text in same line
        textBaseline: TextBaseline.ideographic, //gets text in same line
        children: [
          Text(
            name,
            style: TextStyle(
              fontSize: 16,
              color: theme.contrastColor,
            ),
          ),
          Obx(
            () => Text(
              systemState.ippvModel.ippvValues[name].toString(),
              style: TextStyle(
                fontSize: 32,
                color: theme.contrastColor,
              ),
            ),
          ),
          Text(
            rate,
            style: TextStyle(
              fontSize: 12,
              color: theme.contrastColor,
            ),
          ),
        ],
      ),
    );
  }
}
