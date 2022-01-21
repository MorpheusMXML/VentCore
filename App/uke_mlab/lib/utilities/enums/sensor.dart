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
      'graphLength': 100,
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
    sensorEnumAbsolute.tempAbsolute: {
      'displayString': 'Temperature',
      'displayShortString': 'Temp',
      'abbreviation': 'Temp',
      'unit': '°C',
      'color': AppTheme.tempColor,
      'floatRepresentation': true,
      'boundaryDeviation': 0.1,
      'upperBound': {
        'adult': 37.4,
        'child': 37.4,
        'infant': 37.4,
      },
      'lowerBound': {
        'adult': 36.5,
        'child': 36.5,
        'infant': 36.5,
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
        'adult': 90,
        'child': 90,
        'infant': 90,
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
        'adult': 35,
        'child': 35,
        'infant': 35,
      },
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
        'adult': 8.4,
        'child': 8.0,
        'infant': 7.0,
      },
      'lowerBound': {
        'adult': 5.0,
        'child': 5.0,
        'infant': 5.0,
      },
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
    },
    sensorEnumAbsolute.diaAbsolute: {
      'displayString': 'Diastolic Blood Pressure',
      'displayShortString': 'NIBD',
      'abbreviation': 'DIA',
      'unit': 'mmHg',
      'color': AppTheme.nibdColor,
      'floatRepresentation': false,
      'upperBound': {
        'adult': 90,
        'child': 75,
        'infant': 60,
      },
      'lowerBound': {
        'adult': 80,
        'child': 60,
        'infant': 50,
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
  String get displayShortString => attributes[this]!['displayShortString'] as String;
  String get abbreviation => attributes[this]!['abbreviation'] as String;
  String get unit => attributes[this]!['unit'] as String;
  Color get color => attributes[this]!['color'] as Color;

  ///10 Seconds are a default confirm Duration
  int get confirmDuration => attributes[this]!['confirmDuration'] ?? 10;
  dynamic get boundaryDeviation => attributes[this]!['boundaryDeviation'] as dynamic;
  Map get upperBound => attributes[this]!['upperBound'] as Map<String, dynamic>;
  Map get lowerBound => attributes[this]!['lowerBound'] as Map<String, dynamic>;
  bool get floatRepresentation => attributes[this]!['floatRepresentation'];
}
