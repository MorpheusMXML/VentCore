import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:uke_mlab/providers/alarm_controller.dart';

import 'package:uke_mlab/utilities/enums/sensor.dart';

class DataModelAbsolute extends GetxController {
  late final sensorEnumAbsolute sensorKey;
  late final AlarmController alarmController;

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

    ///Inform [AlarmController] about a value change.
    alarmController.evaluateAlarm(absoluteValue.value, upperAlarmBound.value,
        lowerAlarmBound.value, sensorKey);
  }

  void setUpperAlarmBoundary(double newBoundary) {
    if (newBoundary >= lowerAlarmBound.value) {
      upperAlarmBound.value = newBoundary;
    }
    alarmController.evaluateAlarm(absoluteValue.value, upperAlarmBound.value,
        lowerAlarmBound.value, sensorKey);
  }

  void setLowerAlarmBoundary(double newBoundary) {
    if (newBoundary <= upperAlarmBound.value) {
      lowerAlarmBound.value = newBoundary;
    }
    alarmController.evaluateAlarm(absoluteValue.value, upperAlarmBound.value,
        lowerAlarmBound.value, sensorKey);
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
