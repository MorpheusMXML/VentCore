import 'package:flutter/material.dart';
import 'package:uke_mlab/utilities/app_theme.dart';

enum alarmStatus {
  high,
  middle,
  warning,
  confirmed,
  none,
}

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

  String get name => attributes[this]!['name'] as String;
  int get priority => attributes[this]!['priority'] as int;
  Color get color => attributes[this]!['color'] as Color;
}
