import 'package:uke_mlab/models/enums.dart';
// Atm unsused
// TODO address in DataModel update/set methods
// TODO use in use in AlarmController

class SystemState {
  screenStatus _screenStatus = screenStatus.topLevelScreen;
  final Map<sensors, boundaryState> _violationStates = {};

  SystemState() {
    _violationStates
        .forEach((key, value) => {value = boundaryState.inBoundaries});
  }

  void setBoundaryState(sensors key, boundaryState newState) {
    _violationStates[key] = newState;
  }

  boundaryState? getBoundaryState(sensors key) {
    return _violationStates[key];
  }

  void setScreenStatus(screenStatus newStatus) {
    _screenStatus = newStatus;
  }

  screenStatus getScreenStatus() {
    return _screenStatus;
  }
}
