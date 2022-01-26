/// Enum for alarm message associated with an alarm.
///
/// {@category Enums}
enum alarmMessage {
  suppressed,
  lowerBoundaryViolated,
  upperBoundaryViolated,
  deviation,
  none,
}

/// Attributes associated with [alarmMessage], at the moment just containing a String corresponding to the alarm
extension AlarmMessageAttributes on alarmMessage {
  static const Map<alarmMessage, Map<String, dynamic>> attributes = {
    alarmMessage.suppressed: {
      'message': 'Suppressed Alarm',
    },
    alarmMessage.lowerBoundaryViolated: {
      'message': 'Low',
    },
    alarmMessage.upperBoundaryViolated: {
      'message': 'High',
    },
    alarmMessage.deviation: {
      'message': 'Deviation',
    },
    alarmMessage.none: {
      'message': 'none',
    },
  };

  /// Returns the name associated with the [alarmMessage]
  String get message => attributes[this]!['message'] as String;
}
