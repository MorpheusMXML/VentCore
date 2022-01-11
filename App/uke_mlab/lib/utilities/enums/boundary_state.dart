enum boundaryStateEnum {
  suppressed,
  lowerBoundaryViolated,
  inBoundaries,
  upperBoundaryViolated
}

extension BoundaryAttributes on boundaryStateEnum {
  static const Map<boundaryStateEnum, Map<String, dynamic>> attributes = {
    boundaryStateEnum.suppressed: {
      'message': 'Suppressed Alarm',
    },
    boundaryStateEnum.lowerBoundaryViolated: {
      'message': 'Lower Boundary Violated',
    },
    boundaryStateEnum.inBoundaries: {
      'message': 'In Boundaries',
    },
    boundaryStateEnum.upperBoundaryViolated: {
      'message': 'Upper Boundary Violated',
    },
  };

  String get message => attributes[this]!['message'] as String;
}
