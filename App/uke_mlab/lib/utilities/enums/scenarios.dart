import 'package:uke_mlab/utilities/enums/non_graph_alarm.dart';
import 'package:uke_mlab/utilities/enums/screen_status.dart';
import 'package:uke_mlab/utilities/enums/sensor.dart';

//TODO: COMMENTARY
enum scenariosEnum { standardScenario, scenario1, scenario2, scenario3a, scenario3b, scenario3c, scenario4 }

/// This [extension] on [scenariosEnum] maps a path to the data file to its respective [scenariosEnum].
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

//TODO: COMMENTARY
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
  Map<screenStatusEnum, List<sensorEnumGraph>> get scenarioGraphs => graphs[this]!;
}

/// This [extension] for [scenariosEnum] defines when a [nonGraphAlarmEnum] is supposed to be thrown.
extension ScenarioEnumAttributes on scenariosEnum {
  static const Map<scenariosEnum, Map<sensorEnumGraph, Map<int, Map<String, dynamic>>>> nonMeasurableAlarms = {
    scenariosEnum.standardScenario: {
      sensorEnumGraph.pleth: {
        600: {
          'alarm': nonGraphAlarmEnum.o2empty,
          'priority': 20,
        },
        700: {
          'alarm': nonGraphAlarmEnum.ekgNotConnected,
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
