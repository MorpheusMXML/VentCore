import 'package:flutter/material.dart';
import 'package:uke_mlab/providers/sound_controller.dart';
import 'package:uke_mlab/utilities/app_theme.dart';
import 'package:uke_mlab/utilities/enums/non_graph_alarm.dart';
import 'package:uke_mlab/utilities/enums/sensor.dart';

/// Enum representing the alarm status of a [sensorEnumAbsolute] or [nonGraphAlarmEnum].
///
/// {@category Enums}
enum alarmStatus {
  high,
  middle,
  warning,
  confirmed,
  none,
}

/// Attributes an [alarmStatus] can have.
extension AlarmStatusAttributes on alarmStatus {
  static const Map<alarmStatus, Map<String, dynamic>> attributes = {
    alarmStatus.high: {
      'name': 'high alarm',
      'priority': 100,
      'color': AppTheme.alarmHighColor,
    },
    alarmStatus.middle: {
      'name': 'middle alarm',
      'priority': 50,
      'color': AppTheme.alarmMiddleColor,
    },
    alarmStatus.warning: {
      'name': 'warning',
      'priority': 20,
      'color': AppTheme.alarmWarningColor,
    },
    alarmStatus.confirmed: {
      'name': 'confirmed',
      'priority': 1,
      'color': AppTheme.alarmNoneColor,
    },
    alarmStatus.none: {
      'name': 'none',
      'priority': 0,
      'color': AppTheme.alarmNoneColor,
    },
  };

  /// Returns the name associated with an [alarmStatus]
  String get name => attributes[this]!['name'] as String;

  /// Returns the priority associated with an [alarmStatus]
  int get priority => attributes[this]!['priority'] as int;

  /// Returns the color associated with an [alarmStatus]
  Color get color => attributes[this]!['color'] as Color;

  /// Returns the [SoundIdentifier] associated with an [alarmStatus]
  SoundIdentifier? get sound => attributes[this]!['sound'];
}
