import 'package:flutter/material.dart';
import 'package:uke_mlab/utilities/app_theme.dart';

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

class SensorMapping {
  static const Map<sensorEnumGraph, sensorEnumAbsolute?> sensorMap = {
    sensorEnumGraph.paw: null,
    sensorEnumGraph.flow: null,
    sensorEnumGraph.co2: sensorEnumAbsolute.co2Absolute,
    sensorEnumGraph.pleth: sensorEnumAbsolute.spo2Absolute,
    sensorEnumGraph.ecgCh1:
        null, // could/should be null to avoid double representation, but due to customizability (ecgCh1 = only ecg channel) double representation is accepted
    sensorEnumGraph.ecgCh2: sensorEnumAbsolute.hfAbsolute,
    sensorEnumGraph.cpr: sensorEnumAbsolute.hfAbsolute,
    sensorEnumGraph.nibd: null,
  };
}

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
      'graphLength': 250,
    },
    sensorEnumGraph.ecgCh1: {
      'graphTitle': 'ECG Channel 1',
      'yAxisUnit': 'mV',
      'xAxisUnit': '',
      'color': AppTheme.heartFreqColor,
      'graphLength': 1500,
    },
    sensorEnumGraph.ecgCh2: {
      'graphTitle': 'ECG Channel 2',
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
      'graphTitle': 'NIBD',
      'yAxisUnit': '',
      'xAxisUnit': '',
      'color': AppTheme.nibdColor,
      'graphLength': 10, // intermediate value to be changed or something
    }
  };

  String get graphTitle => attributes[this]!['graphTitle'] as String;
  String get yAxisUnit => attributes[this]!['yAxisUnit'] as String;
  String get xAxisUnit => attributes[this]!['xAxisUnit'] as String;
  Color get color => attributes[this]!['color'] as Color;
  int get graphLength => attributes[this]!['graphLength'] as int;
}

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
      'confirmDuration': 20,
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
        'adult':
            150, // spreadsheet says upper boundary not defined, 150 seems a good compromise
        'child': 150,
        'infant': 150,
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
        'adult': 85,
        'child': 125,
        'infant': 145,
      },
      'lowerBound': {
        'adult': 55,
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
      'displayShortString': 'NIBD',
      'abbreviation': 'DIA',
      'unit': 'mmHg',
      'color': AppTheme.nibdColor,
      'floatRepresentation': false,
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
      'displayShortString': 'NIBD',
      'abbreviation': 'SYS',
      'unit': 'mmHg',
      'color': AppTheme.nibdColor,
      'floatRepresentation': false,
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

  String get displayString => attributes[this]!['displayString'] as String;
  String get displayShortString =>
      attributes[this]!['displayShortString'] as String;
  String get abbreviation => attributes[this]!['abbreviation'] as String;
  String get unit => attributes[this]!['unit'] as String;
  Color get color => attributes[this]!['color'] as Color;

  ///10 Seconds are a default confirm Duration
  int get confirmDuration => attributes[this]!['confirmDuration'] ?? 10;
  dynamic get boundaryDeviation =>
      attributes[this]!['boundaryDeviation'] as dynamic;
  Map get upperBound => attributes[this]!['upperBound'] as Map<String, dynamic>;
  Map get lowerBound => attributes[this]!['lowerBound'] as Map<String, dynamic>;
  bool get floatRepresentation => attributes[this]!['floatRepresentation'];

  /// 1= Monitor Alarm; 2=Ventilation Alarm. Monitor Alarm is default.
  int get alarmType => attributes[this]!['alarmType'] ?? 1;
}
