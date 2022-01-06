import 'package:flutter/material.dart';

enum sensorEnum {
  heartFrequency,
  spo2,
  pulse,
  breathFrequency,
  nibd,
  mve,
  co2
  //TODO expand
}

extension SensorAttributes on sensorEnum {
  static const Map<sensorEnum, Map<String, dynamic>> attributes = {
    sensorEnum.heartFrequency: {
      'displayString': 'Heart Frequency',
      'displayShortString': 'Heart Freq.',
      'abbreviation': 'HF',
      'color': Color(0xFF4CAF50),
      'updateRate': 10,
      'upperBound': {
        'adult': 170,
        'child': 130,
        'infant': 110,
      },
      'lowerBound': {
        'adult': 70,
        'child': 80,
        'infant': 90,
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
  };

  get displayString => attributes[this]!['displayString'] as String;
  get displayShortString => attributes[this]!['displayShortString'] as String;
  get abbreviation => attributes[this]!['abbreviation'] as String;
  get color => attributes[this]!['color'] as Color;
  get updateRate => attributes[this]!['updateRate'] as int;
  get lowerBound => attributes[this]!['lowerBound'] as Map<String, int>;
  get upperBound => attributes[this]!['upperBound'] as Map<String, int>;
}
