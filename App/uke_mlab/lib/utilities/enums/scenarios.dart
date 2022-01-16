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
    scenariosEnum.standardScenario: 'assets/jsons/standard_scenario.json',
    scenariosEnum.scenario1: 'assets/jsons/standard_scenario.json',
    scenariosEnum.scenario2: 'assets/jsons/scenario2_data.json',
    scenariosEnum.scenario3a: 'assets/jsons/scenario3_a_data.json',
    scenariosEnum.scenario3b: 'assets/jsons/scenario3_b_data.json',
    scenariosEnum.scenario3c: 'assets/jsons/scenario3_c_data.json',
    scenariosEnum.scenario4: 'assets/jsons/scenario4_data.json'
  };

  String get scenarioPath => attributes[this]!;
}
