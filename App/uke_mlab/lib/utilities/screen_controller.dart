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
        changeScenario(scenariosEnum.standardScenario);
        return '/main_screen';

      case screenChangeButtonEnum.aedButton:
        // Add behaviour
        if (systemState.patientType == patientTypeEnum.none) {
          modelManager.loadPatientPresets(patientTypeEnum.adult);
        }
        systemState.patientType = patientTypeEnum.adult;
        systemState.screenStatus = screenStatusEnum.defibrillationScreen;
        changeScenario(scenariosEnum.standardScenario);
        return '/main_screen'; //TODO change target screen to defi

      case screenChangeButtonEnum.skipButton:
        // Add behaviour
        if (systemState.patientType == patientTypeEnum.none) {
          modelManager.loadPatientPresets(patientTypeEnum.adult);
        }
        systemState.patientType = patientTypeEnum.adult;
        systemState.screenStatus = screenStatusEnum.mainScreen;
        changeScenario(scenariosEnum.standardScenario);
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

      case screenChangeButtonEnum.standardScenario:
        runningScenario = StandardScenario();
        runningScenario!.startScenario();
        if (systemState.patientType == patientTypeEnum.none) {
          modelManager.loadPatientPresets(patientTypeEnum.adult);
          systemState.patientType = patientTypeEnum.adult;
        }
        return '/main_screen';

      case screenChangeButtonEnum.scenario1:
        //start scenario 1
        return '/main_screen';

      case screenChangeButtonEnum.scenario2:
        //start scenario 2
        return '/main_screen';

      case screenChangeButtonEnum.scenario3a:
        //start scenario 3a
        return '/main_screen';

      case screenChangeButtonEnum.scenario3b:
        //start scenario 3b
        return '/main_screen';

      case screenChangeButtonEnum.scenario3c:
        //start scenario 3c
        return '/main_screen';

      case screenChangeButtonEnum.scenario4:
        //start scenario 4
        return '/main_screen';

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
  void changeScenario(scenariosEnum scenario) {
    Get.find<SystemState>().scenarioStarted = true;
    if (runningScenario is AbstractScenario) {
      if (runningScenario!.scenarioRunning) {
        runningScenario!.stopScenario();
      }
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
