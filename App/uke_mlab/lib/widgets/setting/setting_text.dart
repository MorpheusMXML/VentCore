import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/models/system_state.dart';
import 'package:uke_mlab/utilities/app_theme.dart';

/// Custom widget for the text of one IPPV setting parameter.
///
/// {@category IppvSettings}
class SettingText extends StatelessWidget {
  /// Name of the parameter
  final String name;

  /// Unit of the parameter
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
        crossAxisAlignment: CrossAxisAlignment.baseline, //gets text in same line
        textBaseline: TextBaseline.ideographic, //gets text in same line
        children: [
          Text(name, style: theme.settingTextStyle),
          Obx(
            () => Text(
              systemState.ippvModel.ippvValues[name].toString(),
              style: theme.settingTextStyle2,
            ),
          ),
          Text(
            rate,
            style: theme.settingTextStyle3,
          ),
        ],
      ),
    );
  }
}
