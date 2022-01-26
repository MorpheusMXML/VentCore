/// An enum representing the currently selected Patient Type.
/// {@category Utilities}
/// {@subCategory Enums}
enum patientTypeEnum {
  adult,
  child,
  infant,
  none,
}

/// Extension for [patientTypeEnum] containing the map [attributes] which holds a String representing each [patientTypeEnum].
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

  /// Returns the String corresponding to given [patientTypeEnum]
  String get displayString => attributes[this]!['displayString'] as String;
}
