import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/models/screen_element_models/general_alarms.dart';
import 'package:intl/intl.dart';
import 'package:uke_mlab/models/system_state.dart';
import 'package:uke_mlab/utilities/app_theme.dart';
import 'package:uke_mlab/utilities/enums/non_graph_alarm.dart';
import 'package:uke_mlab/widgets/appbar/alarm_counter_tile.dart';

/// Describes an entry for the possible dropDownButton menu creatable by [AlarmCounterTile] under certain conditions.
///
/// {@category AppBar}
class AlarmFieldTile extends StatelessWidget {
  final AlarmListEntry data;
  const AlarmFieldTile({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Material(
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          color: data.toColor(),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              flex: 3,
              child: Container(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  DateFormat.Hms().format(data.time),
                  style: theme.alarmFieldTextStyle,
                ),
              ),
            ),
            Flexible(
              flex: 9,
              child: Center(
                child: Text(
                  data.alarm.message,
                  style: theme.alarmFieldTextStyle,
                ),
              ),
            ),
            ElevatedButton(
              style: theme.alarmFieldButtonStyle,
              onPressed: () =>
                  Get.find<SystemState>().generalAlarms.removeAlarm(data.alarm),
              child: const Icon(Icons.check),
            ),
          ],
        ),
      ),
    );
  }
}
