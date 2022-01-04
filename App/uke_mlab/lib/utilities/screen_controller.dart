import 'package:get/get.dart';
import 'package:uke_mlab/models/enums.dart';
import 'package:uke_mlab/models/model.dart';
import 'package:uke_mlab/models/model_manager.dart';
import 'package:uke_mlab/models/system_state.dart';
import 'package:uke_mlab/scenarios/abstract_scenario.dart';
import 'package:uke_mlab/scenarios/standard_scenario.dart';

class ScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ScreenController());
  }
}

// basic controller to interact with model
// (at the moment) just boundary update
class ScreenController {
  AbstractScenario? runningScenario;

  void setUpperBoundary(DataModel dataModel, int value) {
    dataModel.upperAlarmBound.value = value;
  }

  void setLowerBoundary(DataModel dataModel, int value) {
    dataModel.lowerAlarmBound.value = value;
  }

  void loadPatientPresets(patientTypeEnum patientType) {}

  // OVERLOADING NOT SUPPORTED?! => parameter number at the end
  // additionalInfo can be Null
  // Since each button for screen change has 1 target, this is used for finding direction
  String changeScreen(screenChangeButtonEnum sourceButton,
      {String additionalInfo = ''}) {
    SystemState systemState = Get.find<SystemState>();
    ModelManager modelManager = Get.find<ModelManager>();

    switch (sourceButton) {
      case screenChangeButtonEnum.continueButton:
        // Add behaviour
        if (additionalInfo == 'Adult') {
          if (systemState.patientType != patientTypeEnum.adult) {
            modelManager.loadPatientPresets(patientTypeEnum.adult);
            systemState.patientType = patientTypeEnum.adult;
          }
        } else if (additionalInfo == 'Child') {
          if (systemState.patientType != patientTypeEnum.child) {
            modelManager.loadPatientPresets(patientTypeEnum.child);
            systemState.patientType = patientTypeEnum.child;
          }
        } else if (additionalInfo == 'Infant') {
          if (systemState.patientType != patientTypeEnum.infant) {
            modelManager.loadPatientPresets(patientTypeEnum.infant);
            systemState.patientType = patientTypeEnum.infant;
          }
        } else {
          throw Exception(
              'additionalInformation is not Adult, Child or Infant on screenChangeButton call from Continue Button');
        }
        systemState.screenStatus = screenStatusEnum.mainScreen;
        startScenario(scenariosEnum.standardScenario);
        return '/main_screen';

      case screenChangeButtonEnum.aedButton:
        // Add behaviour
        if (systemState.patientType == patientTypeEnum.none) {
          modelManager.loadPatientPresets(patientTypeEnum.adult);
        }
        systemState.patientType = patientTypeEnum.adult;
        systemState.screenStatus = screenStatusEnum.defibrillationScreen;
        startScenario(scenariosEnum.standardScenario);
        return '/main_screen'; //TODO change target screen to defi

      case screenChangeButtonEnum.skipButton:
        // Add behaviour
        if (systemState.patientType == patientTypeEnum.none) {
          modelManager.loadPatientPresets(patientTypeEnum.adult);
        }
        systemState.patientType = patientTypeEnum.adult;
        systemState.screenStatus = screenStatusEnum.mainScreen;
        startScenario(scenariosEnum.standardScenario);
        return '/main_screen';

      case screenChangeButtonEnum.toTopLevelButton:
        // Add behaviour
        systemState.screenStatus = screenStatusEnum.topLevelScreen;
        return '';

      case screenChangeButtonEnum.ventilationButton:
        // Add behaviour
        systemState.screenStatus = screenStatusEnum.ventilationScreen;
        return '';

      case screenChangeButtonEnum.defiButton:
        // Add behaviour
        systemState.screenStatus = screenStatusEnum.defibrillationScreen;
        return '';

      case screenChangeButtonEnum.mainButton:
        // Add behaviour
        systemState.screenStatus = screenStatusEnum.mainScreen;
        return '';

      default:
        throw Exception('No Button ' +
            sourceButton.toString() +
            ' given for screen change known');
    }
  }

  //TODO implement
  void muteAlarm() {}

  //TODO implement
  void acknowledgeAlarm() {}

  //TODO add interaction with scenarios when scenarios are present
  void startScenario(scenariosEnum scenario) {
    Get.find<SystemState>().scenarioStarted = true;
    if (runningScenario is AbstractScenario) {
      if (runningScenario!.scenarioRunning) {
        runningScenario!.stopScenario();
      }
    }

    switch (scenario) {
      case scenariosEnum.standardScenario:
        runningScenario = StandardScenario();
        runningScenario!.startScenario();
        break;
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
      default: // return Error 'no scenario with such a number found' vs start one of the scenarios with a hint
    }
  }

  void nextStep() {
    if (Get.find<SystemState>().scenarioStarted) {
      // go to the next stopping point in simmulation data (see patient stories)
    }
    // else case for throwing some kind of error message?
  }

  void endScenario(ModelManager manager) {
    SystemState systemState = Get.find<SystemState>();
    if (systemState.scenarioStarted) {
      //stop scenario
      //reset data models in manager ?
      systemState.scenarioStarted = false;
    }
    // else case for throwing some kind of error message?
  }
}
