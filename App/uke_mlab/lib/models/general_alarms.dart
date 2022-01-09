import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/models/system_state.dart';
import 'package:uke_mlab/utilities/enums/non_graph_alarm.dart';

class GeneralAlarms {
  /// offers a sorted list of general alarms for being displayed in [AppBar]

  final RxList<AlarmListEntry> alarmList = <AlarmListEntry>[].obs;

  GeneralAlarms();

  // adds an alarm to list, needs a suitable alarm type and a priority of said alarm
  // only one alarm of each type can be present at the same time => remove if no longer in place!!!
  // the highest alarm priority persists if an alarm is added and one of the same type is already present
  void addAlarm(nonGraphAlarmEnum alarm, int priority) {
    int index =
        alarmList.toList().indexWhere((element) => element.alarm == alarm);
    if (index == -1) {
      //same as does not exist
      alarmList.add(AlarmListEntry(alarm: alarm, priority: priority));
    } else {
      if (alarmList[index].priority <= priority) {
        removeAlarm(alarm);
        alarmList.add(AlarmListEntry(alarm: alarm, priority: priority));
      }
    }

    alarmList.toList().sort((a, b) => a.priority.compareTo(b.priority));
  }

  // if alarm of type nonGraphAlarmEnum does exist in List, it is removed from list
  void removeAlarm(nonGraphAlarmEnum alarm) {
    int index =
        alarmList.toList().indexWhere((element) => element.alarm == alarm);
    if (index != -1) {
      alarmList.removeAt(index);
    }
  }

  // checks whether an alarm of type nonGraphAlarmEnum is contained in List
  bool checkForAlarm(nonGraphAlarmEnum alarm) {
    return alarmList.toList().indexWhere((element) => element.alarm == alarm) ==
        -1;
  }
}

class AlarmListEntry {
  /// an entry for [GeneralAlarms] alarm List, contained in [SystemState] and displayed in [AppBar]

  final nonGraphAlarmEnum alarm;
  final DateTime time = DateTime.now();
  final int priority;

  AlarmListEntry({
    required this.alarm,
    required this.priority,
  });
}
