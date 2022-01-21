import 'package:uke_mlab/utilities/enums/alarm_status.dart';
import 'package:uke_mlab/utilities/enums/non_graph_alarm.dart';
import 'package:uke_mlab/utilities/enums/sensor.dart';

enum scenariosEnum { standardScenario, scenario1, scenario2, scenario3a, scenario3b, scenario3c, scenario4 }

extension ScenarioEnumPath on scenariosEnum {
  static const Map<scenariosEnum, String> attributes = {
    scenariosEnum.standardScenario: 'assets/jsons/standard_scenario.json',
    scenariosEnum.scenario1: 'assets/jsons/scenario1_data.json',
    scenariosEnum.scenario2: 'assets/jsons/scenario2_data.json',
    scenariosEnum.scenario3a: 'assets/jsons/scenario3_a_data.json',
    scenariosEnum.scenario3b: 'assets/jsons/scenario3_b_data.json',
    scenariosEnum.scenario3c: 'assets/jsons/scenario3_c_data.json',
    scenariosEnum.scenario4: 'assets/jsons/scenario4_data.json'
  };

  String get scenarioPath => attributes[this]!;
}

extension ScenarioEnumAttributes on scenariosEnum {
  static const Map<scenariosEnum, Map<sensorEnumGraph, Map<int, Map<String, dynamic>>>> nonMeasurableAlarms = {
    scenariosEnum.standardScenario: {
      sensorEnumGraph.pleth: {
        700: {
          'alarm': nonGraphAlarmEnum.o2empty,
          'priority': 20,
        },
      },
    },
    scenariosEnum.scenario1: {
      sensorEnumGraph.pleth: {
        300: {
          'alarm': nonGraphAlarmEnum.spo2bad,
          'priority': 50 //alarmStatus.warning,
        },
      },
    },
    scenariosEnum.scenario2: {
      sensorEnumGraph.ecgCh1: {
        2500: {
          'alarm': nonGraphAlarmEnum.vt,
          'priority': 50 //alarmStatus.middle,
        },
        3500: {
          'alarm': nonGraphAlarmEnum.leckageHigh,
          'priority': 50 //alarmStatus.middle,
        },
        4000: {
          'alarm': nonGraphAlarmEnum.ventDisconnect,
          'priority': 50 //alarmStatus.middle,
        },
        10000: {
          'alarm': nonGraphAlarmEnum.o2low,
          'priority': 50 // alarmStatus.middle,
        },
        15000: {
          'alarm': nonGraphAlarmEnum.o2empty,
          'priority': 50 // alarmStatus.high,
        },
        18500: {
          'alarm': nonGraphAlarmEnum.ekgArtifact,
          'priority': 50 //alarmStatus.warning,
        },
        100000: {
          'alarm': nonGraphAlarmEnum.lostConnection,
          'priority': 50 //alarmStatus.high,
        }
      },
    },
    scenariosEnum.scenario3a: {
      sensorEnumGraph.ecgCh2: {
        2000: {
          'alarm': nonGraphAlarmEnum.ventDisconnect,
          'priority': 50 // alarmStatus.high,
        },
        4000: {
          'alarm': nonGraphAlarmEnum.ekgNotConnected,
          'priority': 50 // alarmStatus.high,
        },
        5500: {
          'alarm': nonGraphAlarmEnum.spo2disconnected,
          'priority': 50 // alarmStatus.middle,
        },
        60000: {
          'alarm': nonGraphAlarmEnum.vf,
          'priority': 50 // alarmStatus.high,
        }
      }
    },
    scenariosEnum.scenario3b: {
      sensorEnumGraph.pleth: {
        800: {
          'alarm': nonGraphAlarmEnum.spo2bad,
          'priority': 50 // alarmStatus.warning,
        },
      }
    },
    scenariosEnum.scenario3c: {
      sensorEnumGraph.ecgCh2: {
        2000: {
          'alarm': nonGraphAlarmEnum.ekgArtifact,
          'priority': 50 // alarmStatus.warning,
        },
        15500: {
          'alarm': nonGraphAlarmEnum.spo2bad,
          'priority': 50 // alarmStatus.warning,
        },
        9500: {
          'alarm': nonGraphAlarmEnum.vt,
          'priority': 50 // alarmStatus.warning,
        },
      }
    },
    scenariosEnum.scenario4: {
      sensorEnumGraph.ecgCh2: {
        2000: {
          'alarm': nonGraphAlarmEnum.vt,
          'priority': 50 // alarmStatus.high,
        },
        4500: {
          'alarm': nonGraphAlarmEnum.spo2bad,
          'priority': 50 // alarmStatus.middle,
        },
      }
    },
  };
  Map<sensorEnumGraph, Map<int, Map<String, dynamic>>> get scenarioMap => nonMeasurableAlarms[this]!;
}
