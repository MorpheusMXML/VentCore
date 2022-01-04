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
  topLevelScreen,
  mainScreen,
  ventilationScreen,
  defibrillationScreen
}

enum screenChangeButtonEnum {
  aedButton,
  continueButton,
  skipButton,
  toTopLevelButton,
  ventilationButton,
  defiButton,
  mainButton,
}
