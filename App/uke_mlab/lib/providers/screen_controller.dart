import 'package:get/get.dart';
import 'package:uke_mlab/scenarios/scenario_1.dart';
import 'package:uke_mlab/utilities/enums/scenarios.dart';
import 'package:uke_mlab/utilities/enums/patient_type.dart';
import 'package:uke_mlab/utilities/enums/screen_status.dart';
import 'package:uke_mlab/models/model.dart';
import 'package:uke_mlab/models/model_manager.dart';
import 'package:uke_mlab/models/system_state.dart';
import 'package:uke_mlab/scenarios/abstract_scenario.dart';
import 'package:uke_mlab/scenarios/standard_scenario.dart';

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
        resetToggleView();
      }
    }

    switch (scenario) {
      case scenariosEnum.standardScenario:
        runningScenario = StandardScenario();
        runningScenario!.startScenario();
        break;
      case scenariosEnum.scenario1:
        runningScenario = Scenario1();
        runningScenario!.startScenario();
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

  Future? continueButton(String additionalInfo) {
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
    return Get.toNamed('/main_screen');
  }

  Future? skipButton() {
    if (systemState.patientType == patientTypeEnum.none) {
      modelManager.loadPatientPresets(patientTypeEnum.adult);
      systemState.patientType = patientTypeEnum.adult;
    }
    //systemState.patientType = patientTypeEnum.adult;
    systemState.screenStatus = screenStatusEnum.monitorScreen;
    changeScenario(scenariosEnum.standardScenario);
    return Get.toNamed('/main_screen');
  }

  Future? aedButton() {
    if (systemState.patientType == patientTypeEnum.none) {
      modelManager.loadPatientPresets(patientTypeEnum.adult);
      systemState.patientType = patientTypeEnum.adult;
    }
    //systemState.patientType = patientTypeEnum.adult;
    systemState.screenStatus = screenStatusEnum.defibrillationScreen;
    changeScenario(scenariosEnum.standardScenario);
    systemState.selectedToggleView.value = [false, false, true];
    return Get.toNamed('/main_screen');
  }

  Future? patientSettingButton() {
    systemState.screenStatus = screenStatusEnum.patientSettingScreen;
    return Get.offNamed('/start_screen');
  }

  Future? demoScreenButton() {
    return Get.offNamed('/demo_screen');
  }

  void setSelectedToggleView(int index) {
    for (var i = 0; i <= systemState.selectedToggleView.length - 1; i++) {
      index == i
          ? systemState.selectedToggleView[i] = true
          : systemState.selectedToggleView[i] = false;
    }
    if (index == 0) {
      systemState.screenStatus = screenStatusEnum.monitorScreen;
    } else if (index == 1) {
      systemState.screenStatus = screenStatusEnum.ventilationScreen;
    } else if (index == 2) {
      systemState.screenStatus = screenStatusEnum.defibrillationScreen;
    } else {
      throw Exception("No screen $index known in toggle view");
    }
  }

  void resetToggleView() {
    systemState.selectedToggleView.value = [true, false, false];
  }

  Future? alarmSettingsButton() {
    //system state should stay the same here
    return Get.offNamed('/alarm_limit_screen');
  }

  //TODO use and implement
  String alarmSettingsExitButton() {
    return "";
  }

  Future? scenarioMenuExitButton() {
    switch (systemState.screenStatus) {
      case screenStatusEnum.patientSettingScreen:
        return Get.toNamed('/start_screen');
      case screenStatusEnum.monitorScreen:
        return Get.toNamed('/main_screen');
      case screenStatusEnum.ventilationScreen:
        return Get.toNamed('/main_screen');
      case screenStatusEnum.defibrillationScreen:
        return Get.toNamed('/main_screen');
      default:
        throw Exception('unkown previous screen exiting Demo/Scenario Screen');
    }
  }

  Future? scenarioButton(scenariosEnum scenario) {
    if (systemState.patientType == patientTypeEnum.none) {
      modelManager.loadPatientPresets(patientTypeEnum.adult);
      systemState.patientType = patientTypeEnum.adult;
    }
    changeScenario(scenario);
    return Get.toNamed('/main_screen');
  }
}
