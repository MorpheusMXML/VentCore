import 'package:uke_mlab/utilities/enums/alarm_status.dart';
import 'package:uke_mlab/utilities/enums/non_graph_alarm.dart';
import 'package:uke_mlab/utilities/enums/screen_status.dart';
import 'package:uke_mlab/utilities/enums/sensor.dart';

/// Contains a key for each scenario available
/// {@category Utilities}
/// {@subCategory Enums}
enum scenariosEnum {
  standardScenario,
  scenario1,
  scenario2,
  scenario3a,
  scenario3b,
  scenario3c,
  scenario4,
}

/// This [extension] on [scenariosEnum] maps a path to the data file to its respective [scenariosEnum].
extension ScenarioEnumPath on scenariosEnum {
  static const Map<scenariosEnum, String> attributes = {
    scenariosEnum.standardScenario: 'assets/jsons/standard_scenario.json',
    scenariosEnum.scenario1: 'assets/jsons/scenario1.json',
    scenariosEnum.scenario2: 'assets/jsons/scenario2.json',
    scenariosEnum.scenario3a: 'assets/jsons/scenario3_a.json',
    scenariosEnum.scenario3b: 'assets/jsons/scenario3_b.json',
    scenariosEnum.scenario3c: 'assets/jsons/scenario3_c.json',
    scenariosEnum.scenario4: 'assets/jsons/scenario4.json'
  };

  /// Returns the path to the scenario data for the given [scenariosEnum].
  String get scenarioPath => attributes[this]!;
}

/// Contains information which [scenariosEnum] feed information on which [sensorEnumGraph] ordered by [screenStatusEnum]
///
/// Used as default graphs displayed in each screen
extension ScenarioEnumDisplayedGraphs on scenariosEnum {
  static const Map<scenariosEnum, Map<screenStatusEnum, List<sensorEnumGraph>>> graphs = {
    scenariosEnum.standardScenario: {
      screenStatusEnum.monitorScreen: <sensorEnumGraph>[
        sensorEnumGraph.ecgCh2, // medical standard ecg channel is channel 2
        sensorEnumGraph.co2,
        sensorEnumGraph.pleth,
      ],
      screenStatusEnum.ventilationScreen: <sensorEnumGraph>[
        sensorEnumGraph.co2,
        sensorEnumGraph.paw,
        sensorEnumGraph.flow,
      ],
      screenStatusEnum.defibrillationScreen: <sensorEnumGraph>[
        sensorEnumGraph.ecgCh2,
        sensorEnumGraph.co2,
      ],
    },
    scenariosEnum.scenario1: {
      screenStatusEnum.monitorScreen: <sensorEnumGraph>[
        sensorEnumGraph.ecgCh2, // medical standard ecg channel is channel 2
        sensorEnumGraph.pleth,
      ],
      screenStatusEnum.ventilationScreen: <sensorEnumGraph>[],
      screenStatusEnum.defibrillationScreen: <sensorEnumGraph>[
        sensorEnumGraph.ecgCh2,
      ],
    },
    scenariosEnum.scenario2: {
      screenStatusEnum.monitorScreen: <sensorEnumGraph>[
        sensorEnumGraph.ecgCh2, // medical standard ecg channel is channel 2
        sensorEnumGraph.co2,
        sensorEnumGraph.pleth,
      ],
      screenStatusEnum.ventilationScreen: <sensorEnumGraph>[
        sensorEnumGraph.co2,
      ],
      screenStatusEnum.defibrillationScreen: <sensorEnumGraph>[
        sensorEnumGraph.ecgCh2,
        sensorEnumGraph.co2,
      ],
    },
    scenariosEnum.scenario3a: {
      screenStatusEnum.monitorScreen: <sensorEnumGraph>[
        sensorEnumGraph.ecgCh2, // medical standard ecg channel is channel 2
        sensorEnumGraph.co2,
        sensorEnumGraph.pleth,
      ],
      screenStatusEnum.ventilationScreen: <sensorEnumGraph>[
        sensorEnumGraph.co2,
      ],
      screenStatusEnum.defibrillationScreen: <sensorEnumGraph>[
        sensorEnumGraph.ecgCh2,
        sensorEnumGraph.co2,
        sensorEnumGraph.cpr,
      ],
    },
    scenariosEnum.scenario3b: {
      screenStatusEnum.monitorScreen: <sensorEnumGraph>[
        sensorEnumGraph.ecgCh2, // medical standard ecg channel is channel 2
        sensorEnumGraph.co2,
        sensorEnumGraph.pleth,
      ],
      screenStatusEnum.ventilationScreen: <sensorEnumGraph>[
        sensorEnumGraph.co2,
      ],
      screenStatusEnum.defibrillationScreen: <sensorEnumGraph>[
        sensorEnumGraph.ecgCh2,
        sensorEnumGraph.co2,
      ],
    },
    scenariosEnum.scenario3c: {
      screenStatusEnum.monitorScreen: <sensorEnumGraph>[
        sensorEnumGraph.ecgCh2, // medical standard ecg channel is channel 2
        sensorEnumGraph.co2,
        sensorEnumGraph.pleth,
      ],
      screenStatusEnum.ventilationScreen: <sensorEnumGraph>[
        sensorEnumGraph.co2,
      ],
      screenStatusEnum.defibrillationScreen: <sensorEnumGraph>[
        sensorEnumGraph.ecgCh2,
        sensorEnumGraph.co2,
        sensorEnumGraph.cpr,
      ],
    },
    scenariosEnum.scenario4: {
      screenStatusEnum.monitorScreen: <sensorEnumGraph>[
        sensorEnumGraph.ecgCh2, // medical standard ecg channel is channel 2
        sensorEnumGraph.co2,
        sensorEnumGraph.pleth,
      ],
      screenStatusEnum.ventilationScreen: <sensorEnumGraph>[
        sensorEnumGraph.co2,
      ],
      screenStatusEnum.defibrillationScreen: <sensorEnumGraph>[
        sensorEnumGraph.ecgCh2,
        sensorEnumGraph.co2,
        sensorEnumGraph.cpr,
      ],
    }
  };

  /// Returns the map which graphs should be active at default in given [scenariosEnum].
  Map<screenStatusEnum, List<sensorEnumGraph>> get scenarioGraphs => graphs[this]!;
}

/// This [extension] for [scenariosEnum] defines when a [nonGraphAlarmEnum] is supposed to be thrown.
extension ScenarioEnumAttributes on scenariosEnum {
  static Map<scenariosEnum, Map<sensorEnumGraph, Map<int, Map<String, dynamic>>>> nonMeasurableAlarms = {
    scenariosEnum.standardScenario: {
      sensorEnumGraph.pleth: {
        600: {
          'alarm': nonGraphAlarmEnum.o2empty,
          'priority': alarmStatus.warning.priority,
        },
        700: {
          'alarm': nonGraphAlarmEnum.ecgNotConnected,
          'priority': alarmStatus.warning.priority,
        },
      },
    },
    scenariosEnum.scenario1: {
      sensorEnumGraph.pleth: {
        300: {
          'alarm': nonGraphAlarmEnum.spo2bad,
          'priority': alarmStatus.warning.priority,
        },
      },
    },
    scenariosEnum.scenario2: {
      sensorEnumGraph.ecgCh1: {
        2500: {
          'alarm': nonGraphAlarmEnum.vt,
          'priority': alarmStatus.middle.priority,
        },
        3500: {
          'alarm': nonGraphAlarmEnum.leckageHigh,
          'priority': alarmStatus.middle.priority,
        },
        4000: {
          'alarm': nonGraphAlarmEnum.ventDisconnect,
          'priority': alarmStatus.middle.priority,
        },
        10000: {
          'alarm': nonGraphAlarmEnum.o2low,
          'priority': alarmStatus.middle.priority,
        },
        15000: {
          'alarm': nonGraphAlarmEnum.o2empty,
          'priority': alarmStatus.high.priority,
        },
        18500: {
          'alarm': nonGraphAlarmEnum.ecgArtifact,
          'priority': alarmStatus.warning.priority,
        },
        100000: {
          'alarm': nonGraphAlarmEnum.lostConnection,
          'priority': alarmStatus.high.priority,
        }
      },
    },
    scenariosEnum.scenario3a: {
      sensorEnumGraph.ecgCh2: {
        2000: {
          'alarm': nonGraphAlarmEnum.ventDisconnect,
          'priority': alarmStatus.high.priority,
        },
        4000: {
          'alarm': nonGraphAlarmEnum.ecgNotConnected,
          'priority': alarmStatus.high.priority,
        },
        5500: {
          'alarm': nonGraphAlarmEnum.spo2disconnected,
          'priority': alarmStatus.middle.priority,
        },
        60000: {
          'alarm': nonGraphAlarmEnum.vf,
          'priority': alarmStatus.high.priority,
        }
      }
    },
    scenariosEnum.scenario3b: {
      sensorEnumGraph.pleth: {
        800: {
          'alarm': nonGraphAlarmEnum.spo2bad,
          'priority': alarmStatus.warning.priority,
        },
      }
    },
    scenariosEnum.scenario3c: {
      sensorEnumGraph.ecgCh2: {
        2000: {
          'alarm': nonGraphAlarmEnum.ecgArtifact,
          'priority': alarmStatus.warning.priority,
        },
        15500: {
          'alarm': nonGraphAlarmEnum.spo2bad,
          'priority': alarmStatus.warning.priority,
        },
        9500: {
          'alarm': nonGraphAlarmEnum.vt,
          'priority': alarmStatus.warning.priority,
        },
      }
    },
    scenariosEnum.scenario4: {
      sensorEnumGraph.ecgCh2: {
        2000: {
          'alarm': nonGraphAlarmEnum.vt,
          'priority': alarmStatus.high.priority,
        },
        4500: {
          'alarm': nonGraphAlarmEnum.spo2bad,
          'priority': alarmStatus.middle.priority,
        },
      }
    },
  };
  Map<sensorEnumGraph, Map<int, Map<String, dynamic>>> get scenarioMap => nonMeasurableAlarms[this]!;
}
