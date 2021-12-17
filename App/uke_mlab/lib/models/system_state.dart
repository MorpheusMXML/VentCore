import 'package:uke_mlab/models/enums.dart';
// Atm unsused
// TODO address in DataModel update/set methods
// TODO use in use in AlarmController

class SystemState {
  screenStatusEnum screenStatus = screenStatusEnum.topLevelScreen;
  patientTypeEnum patientType = patientTypeEnum.none;
  final Map<sensorEnum, boundaryStateEnum> violationStates = {};
  bool scenarioStarted = false;

  // SystemState initated with no violations at place and screenStatus as topLevelScreen
  SystemState() {
    for (var sensor in sensorEnum.values) {
      violationStates[sensor] = boundaryStateEnum.inBoundaries;
    }
  }
}
