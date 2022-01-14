enum alarmPriority { high, middle, warning, confirmed, none }

extension AlarmPriorityAttributes on alarmPriority {
  static const Map<alarmPriority, Map<String, dynamic>> attributes = {
    alarmPriority.high: {
      'name': 'high alarm',
      'priority': 100,
    },
    alarmPriority.middle: {
      'name': 'middle alarm',
      'priority': 50,
    },
    alarmPriority.warning: {
      'name': 'warning',
      'priority': 20,
    },
    alarmPriority.confirmed: {
      'name': 'confirmed',
      'priority': 1,
    },
    alarmPriority.none: {
      'name': 'none',
      'priority': 0,
    },
  };

  String get prio => attributes[this]!['name'] as String;
  int get priority => attributes[this]!['priority'] as int;
}
