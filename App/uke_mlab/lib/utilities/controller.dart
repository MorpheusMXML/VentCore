import 'package:uke_mlab/models/model.dart';

// basic controller to interact with model
// (at the moment) just boundary update
class Controller {
  bool _scenarioStarted = false;

  void setUpperBoundary(DataModel dataModel, int value) {
    dataModel.updateUpperAlarmBoundary(value);
  }

  void setLowerBoundary(DataModel dataModel, int value) {
    dataModel.updateLowerAlarmBoundary(value);
  }

  //TODO implement
  void muteAlarm() {}

  //TODO implement
  void acknowledgeAlarm() {}

  //TODO add interaction with scenarios when scenarios are present
  void startScenario(int scenarioNumber) {
    _scenarioStarted = true;
    switch (scenarioNumber) {
      case 1:
        //start scenario 1
        break;
      case 2:
        //start scenario 2
        break;
      case 31:
        //start scenario 3a
        break;
      case 32:
        //start scenario 3b
        break;
      case 33:
        //start scenario 3c
        break;
      case 4:
      //start scenario 4
      default: // return Error "no scenario with such a number found" vs start one of the scenarios with a hint
    }
  }

  void nextStep() {
    if (_scenarioStarted) {
      // go to the next stopping point in simmulation data (see patient stories)
    }
    // else case for throwing some kind of error message?
  }

  void endScenario() {
    if (_scenarioStarted) {
      //stop scenario
      //reset values in data model
      _scenarioStarted = false;
    }
    // else case for throwing some kind of error message?
  }
}
