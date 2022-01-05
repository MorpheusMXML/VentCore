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

enum scenariosEnum {
  standardScenario,
  scenario1,
  scenario2,
  scenario3a,
  scenario3b,
  scenario3c,
  scenario4
}

enum boundaryStateEnum {
  suppressed,
  lowerBoundaryViolated,
  inBoundaries,
  upperBoundaryViolated
}

enum patientTypeEnum {
  adult,
  child,
  infant,
  none,
}

enum screenStatusEnum {
  patientSettingScreen,
  monitorScreen,
  ventilationScreen,
  defibrillationScreen
}

enum screenChangeButtonEnum {
  aedButton,
  continueButton,
  skipButton,
  ventilationButton,
  defiButton,
  monitorButton,
  patientSettingsButton,
  scenarioMenuExit,
  standardScenario,
  scenario1,
  scenario2,
  scenario3a,
  scenario3b,
  scenario3c,
  scenario4
}
