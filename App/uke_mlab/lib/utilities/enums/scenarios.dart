enum scenariosEnum {
  standardScenario,
  scenario1,
  scenario2,
  scenario3a,
  scenario3b,
  scenario3c,
  scenario4
}

extension ScenarioEnumAttributes on scenariosEnum {
  static const Map<scenariosEnum, String> attributes = {
    scenariosEnum.standardScenario: 'assets/jsons/standard_scenario',
    scenariosEnum.scenario1: 'assets/jsons/scenario1_data',
    scenariosEnum.scenario2: 'assets/jsons/scenario2_data',
    scenariosEnum.scenario3a: 'assets/jsons/scenario3_a_data',
    scenariosEnum.scenario3b: 'assets/jsons/scenario3_b_data',
    scenariosEnum.scenario3c: 'assets/jsons/scenario3_c_data',
    scenariosEnum.scenario4: 'assets/jsons/scenario4_data'
  };

  String get scenarioPath => attributes[this]!;
}
