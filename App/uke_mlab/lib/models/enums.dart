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
extension ParseToString on sensorEnum {
  String toDisplayString() {
    switch (this) {
      case sensorEnum.heartFrequency:
        return 'Heart Frequency';
      case sensorEnum.breathFrequency:
        return 'Breath Frequency';
      case sensorEnum.co2:
        return 'CO2';
      case sensorEnum.mve:
        return 'MVE';
      case sensorEnum.nibd:
        return 'NIBD';
      case sensorEnum.pulse:
        return 'Pulse';
      case sensorEnum.spo2:
        return 'SpO2';
      default:
        return '';
    }
  }
}
