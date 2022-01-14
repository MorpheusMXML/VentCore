import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:uke_mlab/utilities/enums/sensor.dart';
import 'package:uke_mlab/utilities/enums/boundary_state.dart';
import 'package:uke_mlab/models/system_state.dart';

class DataModelAbsolute extends GetxController {
  late final sensorEnumAbsolute sensorKey;

  Color color = Colors.white;
  String displayString = 'No Default Info';
  String displayShortString = 'No Default';
  String abbreviation = 'NoInfo';
  String unit = 'No Unit';

  bool floatRepresentation = false;

  final RxBool tapped = false.obs; // TODO put somewhere else please

  final RxDouble upperAlarmBound = 0.0.obs;
  final RxDouble lowerAlarmBound = 0.0.obs;

  late double initialUpperBound;
  late double initialLowerBound;

  final RxInt counter = 0.obs;
  final RxDouble absoluteValue = 0.0.obs;
  final RxList<double> historicValues = <double>[].obs;

  final int historicValuesMaxLength = 10;

  final SystemState _systemState = Get.find<SystemState>();

  DataModelAbsolute({
    required this.sensorKey,
    required this.initialUpperBound,
    required this.initialLowerBound,
  }) {
    upperAlarmBound.value = initialUpperBound;
    lowerAlarmBound.value = initialLowerBound;
  }

  void updateValue(double value) {
    counter.value += 1;
    absoluteValue.value = value;

    historicValues.add(value);

    if (historicValues.length + 1 > historicValuesMaxLength) {
      historicValues.removeAt(0);
    }

    //evaluates whether update violated alarm boundaries or returns into boundaries
    if (absoluteValue.value > upperAlarmBound.value) {
      evaluateBoundaryChange(boundaryStateEnum.upperBoundaryViolated);
    } else if (absoluteValue.value < lowerAlarmBound.value) {
      evaluateBoundaryChange(boundaryStateEnum.lowerBoundaryViolated);
    } else {
      evaluateBoundaryChange(boundaryStateEnum.inBoundaries);
    }
  }

  void evaluateBoundaryChange(boundaryState) {
    if (_systemState.violationStates[sensorKey] != boundaryState) {
      _systemState.violationStates[sensorKey] = boundaryState;
      informAlarmController(boundaryState);
    }
  }

  //informs alarmController about change via call
  void informAlarmController(boundaryStateEnum boundaryState) {
    //TODO implement instead of just printing
    //print('$sensorKey had boundary change to $boundaryState');
    //requires information about own state
  }

  void resetDataModel() {
    // reset alarm boundaries
    upperAlarmBound.value = initialUpperBound;
    lowerAlarmBound.value = initialLowerBound;
    //reset singleData to 0 entry
    absoluteValue.value = 0;
    //clear historical data
    historicValues.clear();
  }
}
