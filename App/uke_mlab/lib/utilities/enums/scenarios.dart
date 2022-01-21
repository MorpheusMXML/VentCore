import 'package:uke_mlab/utilities/enums/non_graph_alarm.dart';
import 'package:uke_mlab/utilities/enums/sensor.dart';

enum scenariosEnum {
  standardScenario,
  scenario1,
  scenario2,
  scenario3a,
  scenario3b,
  scenario3c,
  scenario4
}

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
  static const Map<scenariosEnum,
          Map<sensorEnumGraph, Map<int, Map<String, dynamic>>>>
      nonMeasurableAlarms = {
    scenariosEnum.standardScenario: {
      sensorEnumGraph.paw: {},
      sensorEnumGraph.flow: {},
      sensorEnumGraph.co2: {},
      sensorEnumGraph.pleth: {
        700: {
          'alarm': nonGraphAlarmEnum.o2empty,
          'priority': 20,
        },
      },
      sensorEnumGraph.ecgCh1: {},
      sensorEnumGraph.ecgCh2: {},
      sensorEnumGraph.nibd: {},
    },
    scenariosEnum.scenario1: {
      sensorEnumGraph.pleth: {
        800: {
          'alarm': nonGraphAlarmEnum.o2empty,
          'priority': 20,
        },
        1000: {
          'alarm': nonGraphAlarmEnum.o2low,
          'priority': 60,
        },
        1200: {
          'alarm': nonGraphAlarmEnum.cprFeedback,
          'priority': 100,
        },
      },
      sensorEnumGraph.ecgCh1: {},
      sensorEnumGraph.ecgCh2: {},
      sensorEnumGraph.nibd: {},
    },
    scenariosEnum.scenario2: {
      sensorEnumGraph.co2: {},
      sensorEnumGraph.pleth: {},
      sensorEnumGraph.ecgCh1: {},
      sensorEnumGraph.ecgCh2: {},
      sensorEnumGraph.nibd: {},
    },
    scenariosEnum.scenario3a: {},
    scenariosEnum.scenario3b: {},
    scenariosEnum.scenario3c: {},
    scenariosEnum.scenario4: {},
  };
  Map<sensorEnumGraph, Map<int, Map<String, dynamic>>> get scenarioMap =>
      nonMeasurableAlarms[this]!;
}
