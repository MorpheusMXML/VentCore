import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:uke_mlab/providers/alarm_controller.dart';
import 'package:uke_mlab/providers/sound_controller.dart';

import 'package:uke_mlab/utilities/enums/sensor.dart';

import 'package:uke_mlab/widgets/value_box/value_box_container.dart';

class DataModelAbsolute extends GetxController {
  /// represents the data model to be used in [ValueBoxContainer] and subwidgets

  /// sensor key hinting at the corresponding sensor addressing the current [DataModelAbsolute]
  late final sensorEnumAbsolute sensorKey;

  /// reference to the [AlarmController] of the system
  late final AlarmController alarmController;

  /// default color for the [ValueBoxContainer]'s texts (to be overridden with actual color representing the corresponding sensor)
  Color color = Colors.white;

  /// default display String for the [ValueBoxContainer]'s texts (to be overridden with actual text representing the corresponding sensor)
  String displayString = 'No Default Info';

  /// default display short String for the [ValueBoxContainer]'s texts (to be overridden with actual text representing the corresponding sensor)
  String displayShortString = 'No Default';

  /// default abbreviation for the [ValueBoxContainer]'s texts (to be overridden with actual text representing the corresponding sensor)
  String abbreviation = 'NoInfo';

  /// default unit for the [ValueBoxContainer]'s texts (to be overridden with actual text representing the corresponding sensor)
  String unit = 'No Unit';

  /// contains information whether the corresponding [ValueBoxContainer] will be showing floats or int representation of values (think heart frequency vs temperature)
  bool floatRepresentation = false;

  /// contains information whether the alarm boundary settings of the corresponding [ValueBoxContainer] are expanded
  final RxBool expanded = false.obs; // TODO put somewhere else please

  /// representation of the upper alarm bound for the corresponding sensor
  final RxDouble upperAlarmBound = 0.0.obs;

  /// representation of the lower alarm bound for the corresponding sensor
  final RxDouble lowerAlarmBound = 0.0.obs;

  /// representation of the initial upper alarm bound for the corresponding sensor (required for resets)
  late double initialUpperBound;

  /// representation of the initial lower alarm bound for the corresponding sensor (required for resets)
  late double initialLowerBound;

  /// counter of how many updates have been made since start
  final RxInt counter = 0.obs;

  /// representation of the latest value the corresponding sensor pushed to the device
  final RxDouble absoluteValue = 0.0.obs;

  /// representation of the latest [historicValuesMaxLength] values pushed by the corresponding sensor
  final RxList<double> historicValues = <double>[].obs;

  /// indicates how many values [historicValues] shall save
  final int historicValuesMaxLength = 10;

  /// constructor of [DataModelAbsolute]
  /// takes and sets [sensorKey], [initialLowerBound], [initialUpperBound]
  /// [lowerAlarmBound] will be equal to [initialLowerBound] and
  /// [upperAlarmBound] will be equal to [initialUpperBound]
  DataModelAbsolute({
    required this.sensorKey,
    required this.initialUpperBound,
    required this.initialLowerBound,
  }) {
    upperAlarmBound.value = initialUpperBound;
    lowerAlarmBound.value = initialLowerBound;
  }

  /// updates [absoluteValue] with [value], incrementing [counter] and adds the respective new entry to [historicValues],
  /// informs the systems [AlarmController] about an update
  void updateValue(double value) {
    counter.value += 1;
    absoluteValue.value = value;

    historicValues.add(value);

    if (historicValues.length + 1 > historicValuesMaxLength) {
      historicValues.removeAt(0);
    }

    // Inform alarmController about a value change.
    alarmController.evaluateAlarm(absoluteValue.value, upperAlarmBound.value, lowerAlarmBound.value, historicValues, sensorKey);
  }

  /// sets [upperAlarmBound] to [newBoundary] if [newBoundary] >= [lowerAlarmBound] is true
  /// informs the systems [AlarmController] about an update
  void setUpperAlarmBoundary(double newBoundary) {
    if (newBoundary >= lowerAlarmBound.value) {
      upperAlarmBound.value = newBoundary;
    }
    alarmController.evaluateAlarm(absoluteValue.value, upperAlarmBound.value, lowerAlarmBound.value, historicValues, sensorKey);
  }

  /// sets [lowerAlarmBound] to [newBoundary] if  [newBoundary] <= [upperAlarmBound] is true
  /// informs the systems [AlarmController] about an update
  void setLowerAlarmBoundary(double newBoundary) {
    if (newBoundary <= upperAlarmBound.value) {
      lowerAlarmBound.value = newBoundary;
    }
    alarmController.evaluateAlarm(absoluteValue.value, upperAlarmBound.value, lowerAlarmBound.value, historicValues, sensorKey);
  }

  /// resets model to default values and clears [historicValues]
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
