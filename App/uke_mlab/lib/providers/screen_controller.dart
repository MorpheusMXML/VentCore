import 'package:get/get.dart';
import 'package:uke_mlab/models/data_models/model_absolute.dart';
import 'package:uke_mlab/scenarios/patient_scenario.dart';
import 'package:uke_mlab/utilities/enums/scenarios.dart';
import 'package:uke_mlab/utilities/enums/patient_type.dart';
import 'package:uke_mlab/utilities/enums/screen_status.dart';
import 'package:uke_mlab/models/data_models/model_manager.dart';
import 'package:uke_mlab/models/system_state.dart';
import 'package:uke_mlab/scenarios/abstract_scenario.dart';
import 'package:uke_mlab/scenarios/standard_scenario.dart';

// basic controller to interact with model
// (at the moment) just boundary update
class ScreenController {
  AbstractScenario? runningScenario;
  SystemState systemState = Get.find<SystemState>();
  ModelManager modelManager = Get.find<ModelManager>();

  void setUpperBoundary(DataModelAbsolute dataModel, double value) {
    dataModel.setUpperAlarmBoundary(value);
  }

  void setLowerBoundary(DataModelAbsolute dataModel, double value) {
    dataModel.setLowerAlarmBoundary(value);
  }

  //Changes playing scenario based on input paramenter, stops currently playing scenario on call
  void changeScenario(scenariosEnum scenario) {
    systemState.scenarioStarted = true;

    if (runningScenario is AbstractScenario) {
      if (runningScenario!.scenarioRunning) {
        runningScenario!.stopScenario();
        modelManager.resetAllModels();
        resetToggleView();
        systemState.generalAlarms.resetAlarms();
        runningScenario!.stopTimers();
      }
    }

    switch (scenario) {
      case scenariosEnum.standardScenario:
        runningScenario = StandardScenario();
        runningScenario!.startScenario(scenarioPath: scenario.scenarioPath);
        break;
      case scenariosEnum.scenario1:
      case scenariosEnum.scenario2:
      case scenariosEnum.scenario3a:
      case scenariosEnum.scenario3b:
      case scenariosEnum.scenario3c:
      case scenariosEnum.scenario4:
        runningScenario = PatientScenario(scenarioType: scenario);
        runningScenario!.startScenario(scenarioPath: scenario.scenarioPath);
        break;
      default:
        throw Exception('No scenario for ${scenario.name} known.');
    }
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
    systemState.absAlarmFieldModel.updateActiveList();
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
    systemState.absAlarmFieldModel.updateActiveList();
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
    systemState.setSelectedToggleView([false, false, true]);
    systemState.absAlarmFieldModel.updateActiveList();
    return Get.toNamed('/main_screen');
  }

  Future? patientSettingButton() {
    systemState.screenStatus = screenStatusEnum.patientSettingScreen;
    systemState.absAlarmFieldModel.closeOverlay();
    return Get.offNamed('/start_screen');
  }

  Future? demoScreenButton() {
    systemState.absAlarmFieldModel.closeOverlay();
    return Get.offNamed('/demo_screen');
  }

  void setSelectedToggleView(int index) {
    switch (index) {
      case 0:
        systemState.screenStatus = screenStatusEnum.monitorScreen;
        systemState.setSelectedToggleView([true, false, false]);
        systemState.absAlarmFieldModel.updateActiveList();
        break;
      case 1:
        systemState.screenStatus = screenStatusEnum.ventilationScreen;
        systemState.setSelectedToggleView([false, true, false]);
        systemState.absAlarmFieldModel.updateActiveList();
        break;
      case 2:
        systemState.screenStatus = screenStatusEnum.defibrillationScreen;
        systemState.setSelectedToggleView([false, false, true]);
        systemState.absAlarmFieldModel.updateActiveList();
        break;
      default:
        throw Exception("No screen $index known in toggle view");
    }
  }

  void resetToggleView() {
    systemState.setSelectedToggleView([true, false, false]);
  }

  Future? alarmSettingsButton() {
    //system state should stay the same here
    systemState.absAlarmFieldModel.closeOverlay();
    if (!modelManager.stylesTraitsLoaded) {
      modelManager.loadDataModelEnvironmentValues();
    }
    return Get.offNamed('/alarm_limit_screen');
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
    systemState.absAlarmFieldModel.updateActiveList();
    return Get.toNamed('/main_screen');
  }
}
