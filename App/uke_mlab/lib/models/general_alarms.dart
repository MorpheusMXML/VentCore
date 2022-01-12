import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/models/model.dart';
import 'package:uke_mlab/utilities/enums/non_graph_alarm.dart';

/// offers a sorted list of general alarms for being displayed in [StatusBar]
class GeneralAlarms {
  final RxList<AlarmListEntry> alarmList = <AlarmListEntry>[].obs;

  GeneralAlarms();

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
    }
  }

  /// checks whether an [alarm] is contained in [alarmList]
  bool checkForAlarm(nonGraphAlarmEnum alarm) {
    return alarmList.indexWhere((element) => element.alarm == alarm) == -1;
  }
}

/// Represents an entry for [GeneralAlarms.alarmList]
class AlarmListEntry {
  /// represents alarms not directly associated with numeric values in [DataModel]
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
    if (priority > 50) {
      return Colors.red;
    }
    return Colors.yellow;
  }
}
