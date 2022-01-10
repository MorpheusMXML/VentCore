import 'package:flutter/material.dart';

enum sensorEnum {
  heartFrequency,
  spo2,
  pulse,
  breathFrequency,
  nibd,
  mve,
  co2,
  ecg,
  paw,
  flow,
  pleth,
  hfAbsolute,
  ecgCh1,
  ecgCh2,
  tempAbsolute,
  nibdAbsolute,
  spo2Absolute,
  co2Absolute
  //TODO expand
}

extension SensorAttributes on sensorEnum {
  static const Map<sensorEnum, Map<String, dynamic>> attributes = {
    sensorEnum.heartFrequency: {
      'displayString': 'Heart Frequency',
      'displayShortString': 'Heart Freq.',
      'abbreviation': 'HF',
      'color': Color(0xFF4CAF50),
      'upperBound': {
        'adult': 120,
        'child': 125,
        'infant': 135,
      },
      'lowerBound': {
        'adult': 70,
        'child': 80,
        'infant': 100,
      },
    },
    sensorEnum.breathFrequency: {
      'displayString': 'Breath Frequency',
      'displayShortString': 'Breath Freq.',
      'abbreviation': 'AF',
      'color': Color(0xFF0CECDD),
      'updateRate': 10,
      'upperBound': {
        'adult': 200,
        'child': 170,
        'infant': 120,
      },
      'lowerBound': {
        'adult': 40,
        'child': 50,
        'infant': 60,
      },
    },
    sensorEnum.co2: {
      'displayString': 'CO2',
      'displayShortString': 'CO2',
      'abbreviation': 'CO2',
      'color': Color(0xFFAf52DE),
      'updateRate': 10,
      'upperBound': {
        'adult': 200,
        'child': 170,
        'infant': 120,
      },
      'lowerBound': {
        'adult': 40,
        'child': 50,
        'infant': 60,
      },
    },
    sensorEnum.mve: {
      'displayString': 'MVE',
      'displayShortString': 'MVE',
      'abbreviation': 'MVE',
      'color': Color(0xFF0CECDD),
      'updateRate': 5,
      'upperBound': {
        'adult': 230,
        'child': 170,
        'infant': 120,
      },
      'lowerBound': {
        'adult': 80,
        'child': 70,
        'infant': 60,
      },
    },
    sensorEnum.nibd: {
      'displayString': 'NIBD',
      'displayShortString': 'NIBD',
      'abbreviation': 'NIBD',
      'color': Color(0xFFDC362E),
      'updateRate': 5,
      'upperBound': {
        'adult': 220,
        'child': 170,
        'infant': 120,
      },
      'lowerBound': {
        'adult': 70,
        'child': 60,
        'infant': 50,
      },
    },
    sensorEnum.pulse: {
      'displayString': 'Pulse',
      'displayShortString': 'Pulse',
      'abbreviation': 'PP',
      'color': Color(0xFF9C27B0),
      'updateRate': 10,
      'upperBound': {
        'adult': 210,
        'child': 180,
        'infant': 130,
      },
      'lowerBound': {
        'adult': 50,
        'child': 60,
        'infant': 70,
      },
    },
    sensorEnum.spo2: {
      'displayString': 'Espiratorial O2',
      'displayShortString': 'Esp. O2',
      'abbreviation': 'SpO2',
      'color': Color(0xFF2196F3),
      'updateRate': 5,
      'upperBound': {
        'adult': 180,
        'child': 140,
        'infant': 120,
      },
      'lowerBound': {
        'adult': 80,
        'child': 90,
        'infant': 100,
      },
    },
    sensorEnum.ecg: {
      'displayString': 'ECG Channel 2',
      'displayShortString': 'ECG Ch.2',
      'abbreviation': 'ECG Ch.2',
      'color': Color(0xFF4CAF50),
      'updateRate': 10,
      'upperBound': {
        'adult': 180,
        'child': 140,
        'infant': 120,
      },
      'lowerBound': {
        'adult': 80,
        'child': 90,
        'infant': 100,
      },
    },
    sensorEnum.paw: {
      'displayString': 'ECG Channel 2',
      'displayShortString': 'ECG Ch.2',
      'abbreviation': 'ECG Ch.2',
      'updateRate': 10,
      'color': Color(0xFF4CAF50),
      'upperBound': {
        'adult': 180,
        'child': 140,
        'infant': 120,
      },
      'lowerBound': {
        'adult': 80,
        'child': 90,
        'infant': 100,
      },
    },
    sensorEnum.flow: {
      'displayString': 'ECG Channel 2',
      'displayShortString': 'ECG Ch.2',
      'abbreviation': 'ECG Ch.2',
      'updateRate': 10,
      'color': Color(0xFF4CAF50),
      'upperBound': {
        'adult': 180,
        'child': 140,
        'infant': 120,
      },
      'lowerBound': {
        'adult': 80,
        'child': 90,
        'infant': 100,
      },
    },
    sensorEnum.pleth: {
      'displayString': 'ECG Channel 2',
      'displayShortString': 'ECG Ch.2',
      'abbreviation': 'ECG Ch.2',
      'updateRate': 10,
      'color': Color(0xFF4CAF50),
      'upperBound': {
        'adult': 180,
        'child': 140,
        'infant': 120,
      },
      'lowerBound': {
        'adult': 80,
        'child': 90,
        'infant': 100,
      },
    },
    sensorEnum.hfAbsolute: {
      'displayString': 'ECG Channel 2',
      'displayShortString': 'ECG Ch.2',
      'abbreviation': 'ECG Ch.2',
      'updateRate': 10,
      'color': Color(0xFF4CAF50),
      'upperBound': {
        'adult': 180,
        'child': 140,
        'infant': 120,
      },
      'lowerBound': {
        'adult': 80,
        'child': 90,
        'infant': 100,
      },
    },
    sensorEnum.ecgCh1: {
      'displayString': 'ECG Channel 2',
      'displayShortString': 'ECG Ch.2',
      'abbreviation': 'ECG Ch.2',
      'updateRate': 10,
      'color': Color(0xFF4CAF50),
      'upperBound': {
        'adult': 180,
        'child': 140,
        'infant': 120,
      },
      'lowerBound': {
        'adult': 80,
        'child': 90,
        'infant': 100,
      },
    },
    sensorEnum.ecgCh2: {
      'displayString': 'ECG Channel 2',
      'displayShortString': 'ECG Ch.2',
      'abbreviation': 'ECG Ch.2',
      'updateRate': 10,
      'color': Color(0xFF4CAF50),
      'upperBound': {
        'adult': 180,
        'child': 140,
        'infant': 120,
      },
      'lowerBound': {
        'adult': 80,
        'child': 90,
        'infant': 100,
      },
    },
    sensorEnum.tempAbsolute: {
      'displayString': 'ECG Channel 2',
      'displayShortString': 'ECG Ch.2',
      'abbreviation': 'ECG Ch.2',
      'updateRate': 10,
      'color': Color(0xFF4CAF50),
      'upperBound': {
        'adult': 180,
        'child': 140,
        'infant': 120,
      },
      'lowerBound': {
        'adult': 80,
        'child': 90,
        'infant': 100,
      },
    },
    sensorEnum.nibdAbsolute: {
      'displayString': 'ECG Channel 2',
      'displayShortString': 'ECG Ch.2',
      'abbreviation': 'ECG Ch.2',
      'updateRate': 10,
      'color': Color(0xFF4CAF50),
      'upperBound': {
        'adult': 180,
        'child': 140,
        'infant': 120,
      },
      'lowerBound': {
        'adult': 80,
        'child': 90,
        'infant': 100,
      },
    },
    sensorEnum.spo2Absolute: {
      'displayString': 'ECG Channel 2',
      'displayShortString': 'ECG Ch.2',
      'abbreviation': 'ECG Ch.2',
      'updateRate': 10,
      'color': Color(0xFF4CAF50),
      'upperBound': {
        'adult': 180,
        'child': 140,
        'infant': 120,
      },
      'lowerBound': {
        'adult': 80,
        'child': 90,
        'infant': 100,
      },
    },
    sensorEnum.co2Absolute: {
      'displayString': 'ECG Channel 2',
      'displayShortString': 'ECG Ch.2',
      'abbreviation': 'ECG Ch.2',
      'updateRate': 10,
      'color': Color(0xFF4CAF50),
      'upperBound': {
        'adult': 180,
        'child': 140,
        'infant': 120,
      },
      'lowerBound': {
        'adult': 80,
        'child': 90,
        'infant': 100,
      },
    },
  };

  String get displayString => attributes[this]!['displayString'] as String;
  String get displayShortString =>
      attributes[this]!['displayShortString'] as String;
  String get abbreviation => attributes[this]!['abbreviation'] as String;
  Color get color => attributes[this]!['color'] as Color;
  int get updateRate => attributes[this]!['updateRate'] as int;
  Map get lowerBound => attributes[this]!['lowerBound'] as Map<String, int>;
  Map get upperBound => attributes[this]!['upperBound'] as Map<String, int>;
}
