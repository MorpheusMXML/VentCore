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
}

enum sensorEnumAbsolute {
  hfAbsolute, // heartfrequency
  tempAbsolute, // temprerature in °C
  spo2Absolute,
  co2Absolute,
  pulse,
  mve,
  breathfrequency,
}

enum sensorEnumNibd {
  nibdAbsolute,
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
  };
}

extension SensorGraphAttributes on sensorEnumGraph {
  static const Map<sensorEnumGraph, Map<String, dynamic>> attributes = {
    sensorEnumGraph.paw: {
      'graphTitle': 'PAW',
      'yAxisUnit': 'mBar',
      'xAxisUnit': '',
      'color': AppTheme.pawColor,
    },
    sensorEnumGraph.flow: {
      'graphTitle': 'Flow',
      'yAxisUnit': 'l/min',
      'xAxisUnit': '',
      'color': AppTheme.flowColor,
    },
    sensorEnumGraph.co2: {
      'graphTitle': 'CO2',
      'yAxisUnit': 'mmHg',
      'xAxisUnit': '',
      'color': AppTheme.co2Color,
    },
    sensorEnumGraph.pleth: {
      'graphTitle': 'Pleth',
      'yAxisUnit': '%',
      'xAxisUnit': '',
      'color': AppTheme.plethColor,
    },
    sensorEnumGraph.ecgCh1: {
      'graphTitle': 'ECG Channel 1',
      'yAxisUnit': 'mV',
      'xAxisUnit': '',
      'color': AppTheme.heartFreqColor,
    },
    sensorEnumGraph.ecgCh2: {
      'graphTitle': 'ECG Channel 2',
      'yAxisUnit': 'mV',
      'xAxisUnit': '',
      'color': AppTheme.heartFreqColor,
    },
    sensorEnumGraph.cpr: {
      'graphTitle': 'CPR',
      'yAxisUnit': 'cm',
      'xAxisUnit': '',
      'color': AppTheme.heartFreqColor,
    },
  };

  String get graphTitle => attributes[this]!['graphTitle'] as String;
  String get yAxisUnit => attributes[this]!['yAxisUnit'] as String;
  String get xAxisUnit => attributes[this]!['xAxisUnit'] as String;
  Color get color => attributes[this]!['color'] as Color;
}

extension SensorAbsoluteAttributes on sensorEnumAbsolute {
  static const Map<sensorEnumAbsolute, Map<String, dynamic>> attributes = {
    sensorEnumAbsolute.hfAbsolute: {
      'displayString': 'Heart Frequency',
      'displayShortString': 'Heart Freq.',
      'abbreviation': 'HF',
      'unit': 'bpm',
      'color': AppTheme.heartFreqColor,
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
      'upperBound': {
        'adult': 37, // 'adult': 37.4,
        'child': 37, // 'child': 37.4,
        'infant': 37, // 'infant': 37.4
      },
      'lowerBound': {
        'adult': 36, // 'adult': 36.5,
        'child': 36, // 'child': 36.5,
        'infant': 36, // 'infant': 36.5,
      },
    },
    sensorEnumAbsolute.spo2Absolute: {
      'displayString': 'Oxygen Saturation',
      'displayShortString': 'SpO2',
      'abbreviation': 'SpO2',
      'unit': '%',
      'color': AppTheme.plethColor,
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
      'upperBound': {
        'adult': 8, // 8.4
        'child': 8,
        'infant': 7,
      },
      'lowerBound': {
        'adult': 5, // 5.0
        'child': 5,
        'infant': 5,
      },
    },
    sensorEnumAbsolute.breathfrequency: {
      'displayString': 'Breath. Freq.',
      'displayShortString': 'Br. Freq.',
      'abbreviation': 'AF',
      'unit': 'br/min',
      'color': AppTheme.breathFrequencyColor,
      'upperBound': {
        'adult': 35,
        'child': 35,
        'infant': 35,
      },
      'lowerBound': {
        'adult': 20,
        'child': 20,
        'infant': 20,
      },
    },
  };

  String get displayString => attributes[this]!['displayString'] as String;
  String get displayShortString =>
      attributes[this]!['displayShortString'] as String;
  String get abbreviation => attributes[this]!['abbreviation'] as String;
  String get unit => attributes[this]!['unit'] as String;
  Color get color => attributes[this]!['color'] as Color;
  Map get upperBound => attributes[this]!['upperBound'] as Map<String, dynamic>;
  Map get lowerBound => attributes[this]!['lowerBound'] as Map<String, dynamic>;
}

extension SensorNibdAttributes on sensorEnumNibd {
  static const Map<sensorEnumNibd, Map<String, dynamic>> attributes = {
    sensorEnumNibd.nibdAbsolute: {
      'displayString':
          'Non Invasive Blood Pressure', // german abbreviation is NIBD (nicht invasiver blutdruck)
      'displayShortString': 'NIBD',
      'abbreviation': 'NIBD',
      'unit': 'mmHg',
      'color': AppTheme.nibdColor,
      'upperBound': {
        // upper&lower bounds vor [SYS,DIA]
        'adult': [130, 90],
        'child': [100, 75],
        'infant': [85, 60], // dia for infant no info found
      },
      'lowerBound': {
        'adult': [120, 80],
        'child': [85, 60],
        'infant': [70, 50],
      },
    },
  };
  String get displayString => attributes[this]!['displayString'] as String;
  String get displayShortString =>
      attributes[this]!['displayShortString'] as String;
  String get abbreviation => attributes[this]!['abbreviation'] as String;
  String get unit => attributes[this]!['unit'] as String;
  Color get color => attributes[this]!['color'] as Color;
  Map get upperBound => attributes[this]!['upperBound'] as Map<String, dynamic>;
  Map get lowerBound => attributes[this]!['lowerBound'] as Map<String, dynamic>;
}
