import 'package:flutter/material.dart';
import 'package:uke_mlab/utilities/app_theme.dart';
import 'package:uke_mlab/utilities/constants/absolute_alarm_field_constants.dart';
import 'package:uke_mlab/widgets/setting/ippv_button.dart';
import 'package:uke_mlab/widgets/setting/setting_tile.dart';

/// Top level widget for the ippv settings.
///
/// Uses:
/// + [IPPVButton]
/// + [SettingTile]
///
/// {@category IppvSettings}
class SettingContainer extends StatelessWidget {
  /// Descriptions for the ippv settings
  final List<Map<String, Object>> data;
  const SettingContainer({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Container(
      color: theme.primarySwatch[50],
      margin: const EdgeInsets.only(
          right: AbsoluteAlarmFieldConst.verticalMargin, top: AbsoluteAlarmFieldConst.verticalMargin),
      child: Column(
        children: [
          const IPPVButton(),
          ...data
              .map((entry) => SettingTile(
                    name: entry['name'].toString(),
                    rate: entry['rate'].toString(),
                  ))
              .toList()
        ],
      ),
    );
  }
}
