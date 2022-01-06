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

// TODO: Write extensions for other enums
extension ParseToString on sensorEnum{
  static const displayStrings = {
    sensorEnum.heartFrequency: 'Heart Frequency',
    sensorEnum.breathFrequency: 'Breath Frequency',
    sensorEnum.co2: 'CO2',
    sensorEnum.mve: 'MVE',
    sensorEnum.nibd: 'NIBD',
    sensorEnum.pulse: 'Pulse',
    sensorEnum.spo2: 'SpO2',
  };

  String get displayString => displayStrings[this] as String;
}
