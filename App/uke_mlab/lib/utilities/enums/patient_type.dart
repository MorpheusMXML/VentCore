//TODO: COMMENTARY
enum patientTypeEnum {
  adult,
  child,
  infant,
  none,
}

//TODO: COMMENTARY
extension BoundaryAttributes on patientTypeEnum {
  static const Map<patientTypeEnum, Map<String, dynamic>> attributes = {
    patientTypeEnum.adult: {
      'displayString': 'Adult',
    },
    patientTypeEnum.child: {
      'displayString': 'Child',
    },
    patientTypeEnum.infant: {
      'displayString': 'Infant',
    },
    patientTypeEnum.none: {
      'displayString': '',
    },
  };

  String get displayString => attributes[this]!['displayString'] as String;
}
