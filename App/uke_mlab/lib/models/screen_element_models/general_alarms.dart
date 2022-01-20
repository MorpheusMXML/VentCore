import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/models/data_models/model_absolute.dart';
import 'package:uke_mlab/utilities/constants/statusbar_constants.dart';
import 'package:uke_mlab/utilities/enums/non_graph_alarm.dart';
import 'package:uke_mlab/widgets/appbar/alarm_list.dart';

class GeneralAlarms extends GetxController {
  /// offers a sorted list of general alarms for being displayed in [StatusBar]

  final RxList<AlarmListEntry> alarmList = <AlarmListEntry>[].obs;
  OverlayEntry? entry;
  RxBool listExpanded = false.obs;

  /// adds an alarm to [alarmList]
  ///
  /// * requires a suitable alarm type and a priority of said alarm
  /// * only one alarm of each type can be present at the same time => remove if alarm is no longer in place
  /// * the highest alarm priority persists if an alarm is added and one of the same type is already present
  void addAlarm(nonGraphAlarmEnum alarm, int priority) {
    int index = alarmList.indexWhere((element) => element.alarm == alarm);
    if (index == -1) {
      // same as does not exist
      alarmList.add(AlarmListEntry(alarm: alarm, priority: priority));
    } else {
      if (alarmList[index].priority <= priority) {
        removeAlarm(alarm);
        alarmList.add(AlarmListEntry(alarm: alarm, priority: priority));
      }
    }

    alarmList.sort((a, b) => b.priority.compareTo(a.priority));
  }

  /// remove [alarm] from list
  ///
  /// if alarm of type [nonGraphAlarmEnum] does not exist in [alarmList] the call does nothing
  void removeAlarm(nonGraphAlarmEnum alarm) {
    int index = alarmList.indexWhere((element) => element.alarm == alarm);
    if (index != -1) {
      alarmList.removeAt(index);
      if (alarmList.length <= 1) {
        hideOverlay();
      }
    }
  }

  /// checks whether an [alarm] is contained in [alarmList]
  bool checkForAlarm(nonGraphAlarmEnum alarm) {
    return alarmList.indexWhere((element) => element.alarm == alarm) == -1;
  }

  void resetAlarms() {
    alarmList.clear();
  }

  void showOverlay(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;

    entry = OverlayEntry(
      builder: (context) => Positioned(
        left: StatusBarConstants.menuButtonWidth,
        top: statusBarHeight,
        child: const AlarmList(),
      ),
    );

    final overlay = Overlay.of(context)!;
    overlay.insert(entry!);
    listExpanded.value = true;
  }

  void hideOverlay() {
    entry?.remove();
    entry = null;
    listExpanded.value = false;
  }
}

/// Represents an entry for [GeneralAlarms.alarmList]
class AlarmListEntry {
  /// represents alarms not directly associated with numeric values in [DataModelAbsolute]
  final nonGraphAlarmEnum alarm;

  /// time the alarm occured
  final DateTime time = DateTime.now();

  /// priority of the alarm, should be between 0 and 100
  final int priority;

  AlarmListEntry({
    required this.alarm,
    required this.priority,
  });

  /// translates the [priority] to a associated color
  Color toColor() {
    if (priority > 0 && priority <= 33) {
      return Colors.green;
    } else if (priority > 33 && priority <= 66) {
      return Colors.yellow;
    }
    return Colors.red;
  }
}
