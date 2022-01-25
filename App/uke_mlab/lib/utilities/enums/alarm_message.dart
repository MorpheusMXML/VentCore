//TODO: COMMENTARY
enum alarmMessage { suppressed, lowerBoundaryViolated, upperBoundaryViolated, deviation, none }

//TODO: COMMENTARY
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

  String get message => attributes[this]!['message'] as String;
}
