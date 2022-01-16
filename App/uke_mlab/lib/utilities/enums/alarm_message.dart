enum alarmMessage {
  suppressed,
  lowerBoundaryViolated,
  inBoundaries,
  upperBoundaryViolated,
  deviation
}

extension AlarmMessageAttributes on alarmMessage {
  static const Map<alarmMessage, Map<String, dynamic>> attributes = {
    alarmMessage.suppressed: {
      'message': 'Suppressed Alarm',
    },
    alarmMessage.lowerBoundaryViolated: {
      'message': 'Lower Boundary Violated',
    },
    alarmMessage.inBoundaries: {
      'message': 'In Boundaries',
    },
    alarmMessage.upperBoundaryViolated: {
      'message': 'Upper Boundary Violated',
    },
    alarmMessage.deviation: {
      'message': 'value deviation detected',
    },
  };

  String get message => attributes[this]!['message'] as String;
}
