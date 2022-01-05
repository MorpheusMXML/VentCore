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
  SystemState systemState = Get.find<SystemState>();
  ModelManager modelManager = Get.find<ModelManager>();

  void setUpperBoundary(DataModel dataModel, int value) {
    dataModel.upperAlarmBound.value = value;
  }

  void setLowerBoundary(DataModel dataModel, int value) {
    dataModel.lowerAlarmBound.value = value;
  }

  //Changes playing scenario based on input paramenter, stops currently playing scenario on call
  void changeScenario(scenariosEnum scenario) {
    systemState.scenarioStarted = true;

    if (runningScenario is AbstractScenario) {
      if (runningScenario!.scenarioRunning) {
        runningScenario!.stopScenario();
        modelManager.resetAllModels();
      }
    }

    switch (scenario) {
      case scenariosEnum.standardScenario:
        runningScenario = StandardScenario();
        runningScenario!.startScenario();
        break;
      case scenariosEnum.scenario1:
        print("start Scenario 1 here");
        break;
      case scenariosEnum.scenario2:
        print("start Scenario 2 here");
        break;
      case scenariosEnum.scenario3a:
        print("start Scenario 3a here");
        break;
      case scenariosEnum.scenario3b:
        print("start Scenario 3b here");
        break;
      case scenariosEnum.scenario3c:
        print("start Scenario 3c here");
        break;
      case scenariosEnum.scenario4:
        print("start Scenario 4 here");
        break;
      default:
        throw Exception('No scenario for ' + scenario.toString() + ' known');
    }
  }

  //TODO implement
  void muteAlarm() {}

  //TODO implement
  void acknowledgeAlarm() {}

  //TODO implement
  void nextStep() {
    if (Get.find<SystemState>().scenarioStarted) {
      // go to the next stopping point in simmulation data (see patient stories)
    }
    // else case for throwing some kind of error message?
  }

  //TODO delete/implement
  void endScenario(ModelManager manager) {
    SystemState systemState = Get.find<SystemState>();
    if (systemState.scenarioStarted) {
      //stop scenario
      //reset data models in manager ?
      systemState.scenarioStarted = false;
    }
    // else case for throwing some kind of error message?
  }

  String continueButton(String additionalInfo) {
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
    systemState.screenStatus = screenStatusEnum.monitorScreen;
    changeScenario(scenariosEnum.standardScenario);
    return '/main_screen';
  }

  String skipButton() {
    if (systemState.patientType == patientTypeEnum.none) {
      modelManager.loadPatientPresets(patientTypeEnum.adult);
    }
    systemState.patientType = patientTypeEnum.adult;
    systemState.screenStatus = screenStatusEnum.monitorScreen;
    changeScenario(scenariosEnum.standardScenario);
    return '/main_screen';
  }

  String aedButton() {
    if (systemState.patientType == patientTypeEnum.none) {
      modelManager.loadPatientPresets(patientTypeEnum.adult);
    }
    systemState.patientType = patientTypeEnum.adult;
    systemState.screenStatus = screenStatusEnum.defibrillationScreen;
    changeScenario(scenariosEnum.standardScenario);
    //TODO set toggle controller to defi
    return '/main_screen';
  }

  String patientSettingButton() {
    systemState.screenStatus = screenStatusEnum.patientSettingScreen;
    return '/start_screen';
  }

  //TODO use and implement
  void monitorButton() {
    systemState.screenStatus = screenStatusEnum.monitorScreen;
    //set toggle controller to monitorScreen
  }

  //TODO use and implement
  void ventilationButton() {
    systemState.screenStatus = screenStatusEnum.ventilationScreen;
    //set toggle controller to ventilationScreen
  }

  //TODO use and implement
  void defiButton() {
    systemState.screenStatus = screenStatusEnum.defibrillationScreen;
    //set toggle controller to ventilationScreen
  }

  //TODO use and implement
  String alarmSettingsButton() {
    //system state should stay the same here
    return "";
  }

  //TODO use and implement
  String alarmSettingsExitButton() {
    return "";
  }

  //TODO use and implement
  String scenarioMenuButton() {
    return "";
  }

  //TODO implement
  String scenarioMenuExitButton() {
    return '/start_screen';
  }

  String scenarioButton(scenariosEnum scenario) {
    if (systemState.patientType == patientTypeEnum.none) {
      modelManager.loadPatientPresets(patientTypeEnum.adult);
      systemState.patientType = patientTypeEnum.adult;
    }
    changeScenario(scenario);
    return '/main_screen';
  }
}
