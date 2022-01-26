import 'package:flutter/material.dart';
import 'package:uke_mlab/utilities/app_theme.dart';

/// Contains a key for each graph currently available in the app
enum sensorEnumGraph {
  paw,
  flow,
  co2,
  pleth,
  ecgCh1,
  ecgCh2,
  cpr,
  nibd,
}

/// Contains a key for each absolute tile currently available in the app
enum sensorEnumAbsolute {
  hfAbsolute, // heartfrequency
  tempAbsolute, // temprerature in °C
  spo2Absolute,
  co2Absolute,
  pulse,
  mve,
  breathfrequency,
  sysAbsolute,
  diaAbsolute,
}

/// Associates a [sensorEnumGraph] with its corresponding [sensorEnumAbsolute]
class SensorMapping {
  static const Map<sensorEnumGraph, sensorEnumAbsolute?> sensorMap = {
    sensorEnumGraph.paw: null,
    sensorEnumGraph.flow: null,
    sensorEnumGraph.co2: sensorEnumAbsolute.co2Absolute,
    sensorEnumGraph.pleth: sensorEnumAbsolute.spo2Absolute,
    sensorEnumGraph.ecgCh1:
        null, // could/should be null to avoid double representation, but due to customizability (ecgCh1 = only ecg channel) double representation is accepted
    sensorEnumGraph.ecgCh2: sensorEnumAbsolute.hfAbsolute,
    sensorEnumGraph.cpr: null,
    sensorEnumGraph.nibd: null,
  };
}

/// Contains default values (eg. names, graphLenght, colors, units) for graphs accessable via [sensorEnumGraph] as key of [attributes].
extension SensorGraphAttributes on sensorEnumGraph {
  static const Map<sensorEnumGraph, Map<String, dynamic>> attributes = {
    sensorEnumGraph.paw: {
      'graphTitle': 'PAW',
      'yAxisUnit': 'mBar',
      'xAxisUnit': '',
      'color': AppTheme.pawColor,
      'graphLength': 1500,
    },
    sensorEnumGraph.flow: {
      'graphTitle': 'Flow',
      'yAxisUnit': 'l/min',
      'xAxisUnit': '',
      'color': AppTheme.flowColor,
      'graphLength': 1500,
    },
    sensorEnumGraph.co2: {
      'graphTitle': 'CO2',
      'yAxisUnit': 'mmHg',
      'xAxisUnit': '',
      'color': AppTheme.co2Color,
      'graphLength': 1500,
    },
    sensorEnumGraph.pleth: {
      'graphTitle': 'Pleth',
      'yAxisUnit': '%',
      'xAxisUnit': '',
      'color': AppTheme.plethColor,
      'graphLength': 150,
    },
    sensorEnumGraph.ecgCh1: {
      'graphTitle': 'ECG Ch. 1',
      'yAxisUnit': 'mV',
      'xAxisUnit': '',
      'color': AppTheme.heartFreqColor,
      'graphLength': 1500,
    },
    sensorEnumGraph.ecgCh2: {
      'graphTitle': 'ECG Ch. 2',
      'yAxisUnit': 'mV',
      'xAxisUnit': '',
      'color': AppTheme.heartFreqColor,
      'graphLength': 1500,
    },
    sensorEnumGraph.cpr: {
      'graphTitle': 'CPR',
      'yAxisUnit': 'cm',
      'xAxisUnit': '',
      'color': AppTheme.heartFreqColor,
      'graphLength': 25,
    },
    sensorEnumGraph.nibd: {
      'graphTitle': 'NIBP',
      'yAxisUnit': '',
      'xAxisUnit': '',
      'color': AppTheme.nibdColor,
      'graphLength': 10, // intermediate value to be changed or something
    }
  };

  /// Returns title of the graph.
  String get graphTitle => attributes[this]!['graphTitle'] as String;

  /// Returns unit of the y-axis of the graph
  String get yAxisUnit => attributes[this]!['yAxisUnit'] as String;

  /// Returns unit of the x-axis of the graph
  String get xAxisUnit => attributes[this]!['xAxisUnit'] as String;

  /// Returns color for the graph
  Color get color => attributes[this]!['color'] as Color;

  /// Returns default length for the graph to be displayed
  int get graphLength => attributes[this]!['graphLength'] as int;
}

/// Contains default values (eg. names, graphLenght, colors, unit) for value tiles accessable via [sensorEnumAbsolute] as key of [attributes].
extension SensorAbsoluteAttributes on sensorEnumAbsolute {
  // child and infant boundaries are mostly made up due to lack of data
  static const Map<sensorEnumAbsolute, Map<String, dynamic>> attributes = {
    sensorEnumAbsolute.hfAbsolute: {
      'displayString': 'Heart Frequency',
      'displayShortString': 'Heart Freq.',
      'abbreviation': 'HF',
      'unit': 'bpm',
      'color': AppTheme.heartFreqColor,
      'floatRepresentation': false,
      'confirmDuration': 90,
      'boundaryDeviation': 0.1,
      'upperBound': {
        'adult': 100,
        'child': 125,
        'infant': 145,
      },
      'lowerBound': {
        'adult': 50,
        'child': 85,
        'infant': 110,
      },
    },
    sensorEnumAbsolute.tempAbsolute: {
      'displayString': 'Temperature',
      'displayShortString': 'Temp',
      'abbreviation': 'Temp',
      'unit': '°C',
      'color': AppTheme.tempColor,
      'floatRepresentation': true,
      'boundaryDeviation': 0.1,
      'upperBound': {
        'adult': 37.9,
        'child': 37.9,
        'infant': 37.9,
      },
      'lowerBound': {
        'adult': 36.0,
        'child': 36.0,
        'infant': 36.0,
      },
    },
    sensorEnumAbsolute.spo2Absolute: {
      'displayString': 'Oxygen Saturation',
      'displayShortString': 'SpO2',
      'abbreviation': 'SpO2',
      'unit': '%',
      'color': AppTheme.plethColor,
      'floatRepresentation': false,
      'boundaryDeviation': 0.1,
      'upperBound': {
        'adult': 100,
        'child': 100,
        'infant': 100,
      },
      'lowerBound': {
        'adult': 92,
        'child': 92,
        'infant': 92,
      },
    },
    sensorEnumAbsolute.co2Absolute: {
      'displayString': 'CO2',
      'displayShortString': 'CO2',
      'abbreviation': 'CO2',
      'unit': 'mmHg',
      'color': AppTheme.co2Color,
      'floatRepresentation': false,
      'boundaryDeviation': 0.1,
      'upperBound': {
        'adult': 45,
        'child': 45,
        'infant': 45,
      },
      'lowerBound': {
        'adult': 30,
        'child': 30,
        'infant': 30,
      },
      'alarmType': 2,
    },
    sensorEnumAbsolute.pulse: {
      'displayString': 'Pulse',
      'displayShortString': 'Pulse',
      'abbreviation': 'PP',
      'unit': 'bpm',
      'color': AppTheme.pulseColor,
      'floatRepresentation': false,
      'boundaryDeviation': 0.1,
      'upperBound': {
        'adult': 100,
        'child': 125,
        'infant': 145,
      },
      'lowerBound': {
        'adult': 50,
        'child': 85,
        'infant': 110,
      },
    },
    // next to temp another float case
    sensorEnumAbsolute.mve: {
      'displayString': 'MVe',
      'displayShortString': 'MVe',
      'abbreviation': 'MVe',
      'unit': 'l/min',
      'color': AppTheme.mveColor,
      'floatRepresentation': true,
      'boundaryDeviation': 0.075,
      'upperBound': {
        'adult': 9.0,
        'child': 8.0,
        'infant': 7.0,
      },
      'lowerBound': {
        'adult': 3.5,
        'child': 3.6,
        'infant': 3.7,
      },
      'alarmType': 2,
    },
    sensorEnumAbsolute.breathfrequency: {
      'displayString': 'Breath. Freq.',
      'displayShortString': 'Br. Freq.',
      'abbreviation': 'AF',
      'unit': 'br/min',
      'color': AppTheme.breathFrequencyColor,
      'floatRepresentation': false,
      'boundaryDeviation': 0.1,
      'upperBound': {
        'adult': 20,
        'child': 28,
        'infant': 40,
      },
      'lowerBound': {
        'adult': 10,
        'child': 13,
        'infant': 33,
      },
      'alarmType': 2,
    },
    sensorEnumAbsolute.diaAbsolute: {
      'displayString': 'Diastolic Blood Pressure',
      'displayShortString': 'NIBP',
      'abbreviation': 'DIA',
      'unit': 'mmHg',
      'color': AppTheme.nibdColor,
      'floatRepresentation': false,
      'boundaryDeviation': 0.1,
      'upperBound': {
        'adult': 100,
        'child': 90,
        'infant': 80,
      },
      'lowerBound': {
        'adult': 40,
        'child': 35,
        'infant': 30,
      },
    },
    sensorEnumAbsolute.sysAbsolute: {
      'displayString': 'Systolic Blood Pressure',
      'displayShortString': 'NIBP',
      'abbreviation': 'SYS',
      'unit': 'mmHg',
      'color': AppTheme.nibdColor,
      'floatRepresentation': false,
      'boundaryDeviation': 0.1,
      'upperBound': {
        'adult': 130,
        'child': 100,
        'infant': 85,
      },
      'lowerBound': {
        'adult': 120,
        'child': 85,
        'infant': 70,
      },
    },
  };

  /// Returns written out name of the sensor represented by [sensorEnumAbsolute].
  String get displayString => attributes[this]!['displayString'] as String;

  /// Returns a shortened version of the sensors represented by [sensorEnumAbsolute] name.
  String get displayShortString =>
      attributes[this]!['displayShortString'] as String;

  /// Returns an abreviation for the sensors represented by [sensorEnumAbsolute] name.
  String get abbreviation => attributes[this]!['abbreviation'] as String;

  /// Returns the unit the sensor represented by [sensorEnumAbsolute] delivers its data in as a String.
  String get unit => attributes[this]!['unit'] as String;

  /// Returns the color the representation of the sensor represented by [sensorEnumAbsolute] shall be rendered.
  Color get color => attributes[this]!['color'] as Color;

  /// Returns the default duration the confirm button of the sensor shall linger.
  ///
  /// 10 Seconds are a default confirm Duration.
  int get confirmDuration => attributes[this]!['confirmDuration'] ?? 60;

  /// Returns the default boundary deviation for this sensor.
  dynamic get boundaryDeviation =>
      attributes[this]!['boundaryDeviation'] as dynamic;

  /// Returns a Map for the default lower bound values of the sensor, containing information for 'adult', 'child' and 'infant'.
  Map get upperBound => attributes[this]!['upperBound'] as Map<String, dynamic>;

  /// Returns a Map for the default upper bound values of the sensor, containing information for 'adult', 'child' and 'infant'.
  Map get lowerBound => attributes[this]!['lowerBound'] as Map<String, dynamic>;
  bool get floatRepresentation => attributes[this]!['floatRepresentation'];

  /// Returns whether this sensor will throw a Monitor or a Ventilation Alarm.
  ///
  /// 1 == Monitor Alarm; 2 == Ventilation Alarm. Monitor Alarm is default.
  int get alarmType => attributes[this]!['alarmType'] ?? 1;
}
