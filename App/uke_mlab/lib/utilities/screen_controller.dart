import 'package:uke_mlab/models/enums.dart';
import 'package:uke_mlab/models/model.dart';
import 'package:uke_mlab/models/model_manager.dart';

// basic controller to interact with model
// (at the moment) just boundary update
class ScreenController {
  bool _scenarioStarted = false;

  void setUpperBoundary(DataModel dataModel, int value) {
    dataModel.upperAlarmBound.value = value;
  }

  void setLowerBoundary(DataModel dataModel, int value) {
    dataModel.lowerAlarmBound.value = value;
  }

  //TODO implement
  void muteAlarm() {}

  //TODO implement
  void acknowledgeAlarm() {}

  //TODO add interaction with scenarios when scenarios are present
  void startScenario(scenariosEnum scenario) {
    _scenarioStarted = true;
    switch (scenario) {
      case scenariosEnum.scenario1:
        //start scenario 1
        break;
      case scenariosEnum.scenario2:
        //start scenario 2
        break;
      case scenariosEnum.scenario3a:
        //start scenario 3a
        break;
      case scenariosEnum.scenario3b:
        //start scenario 3b
        break;
      case scenariosEnum.scenario3c:
        //start scenario 3c
        break;
      case scenariosEnum.scenario4:
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

  void endScenario(ModelManager manager) {
    if (_scenarioStarted) {
      //stop scenario
      //reset data models in manager ?
      _scenarioStarted = false;
    }
    // else case for throwing some kind of error message?
  }
}
