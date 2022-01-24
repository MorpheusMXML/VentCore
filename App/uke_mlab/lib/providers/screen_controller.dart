import 'package:get/get.dart';
import 'package:uke_mlab/models/data_models/model_absolute.dart';
import 'package:uke_mlab/models/screen_element_models/smart_adjustment_model.dart';
import 'package:uke_mlab/providers/alarm_controller.dart';
import 'package:uke_mlab/providers/sound_controller.dart';
import 'package:uke_mlab/scenarios/patient_scenario.dart';
import 'package:uke_mlab/utilities/enums/scenarios.dart';
import 'package:uke_mlab/utilities/enums/patient_type.dart';
import 'package:uke_mlab/utilities/enums/screen_status.dart';
import 'package:uke_mlab/models/data_models/model_manager.dart';
import 'package:uke_mlab/models/system_state.dart';
import 'package:uke_mlab/scenarios/abstract_scenario.dart';
import 'package:uke_mlab/scenarios/standard_scenario.dart';
import 'package:uke_mlab/utilities/enums/sensor.dart';

// basic controller to interact with model
// (at the moment) just boundary update
class ScreenController {
  AbstractScenario? runningScenario;
  SystemState systemState = Get.find<SystemState>();
  ModelManager modelManager = Get.find<ModelManager>();
  SoundController soundController = Get.find<SoundController>();

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
        systemState.graphList.setStandardGraphs(ScenarioEnumDisplayedGraphs
            .graphs[scenario] as Map<screenStatusEnum, List<sensorEnumGraph>>);
        runningScenario!.startScenario(scenarioPath: scenario.scenarioPath);
        break;
      case scenariosEnum.scenario1:
      case scenariosEnum.scenario2:
      case scenariosEnum.scenario3a:
      case scenariosEnum.scenario3b:
      case scenariosEnum.scenario3c:
      case scenariosEnum.scenario4:
        runningScenario = PatientScenario(scenarioType: scenario);
        systemState.graphList.setStandardGraphs(ScenarioEnumDisplayedGraphs
            .graphs[scenario] as Map<screenStatusEnum, List<sensorEnumGraph>>);
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
        systemState.resetSystemState();
      }
    } else if (additionalInfo == 'Child') {
      if (systemState.patientType != patientTypeEnum.child) {
        modelManager.loadPatientPresets(patientTypeEnum.child);
        systemState.patientType = patientTypeEnum.child;
        systemState.resetSystemState();
      }
    } else if (additionalInfo == 'Infant') {
      if (systemState.patientType != patientTypeEnum.infant) {
        modelManager.loadPatientPresets(patientTypeEnum.infant);
        systemState.patientType = patientTypeEnum.infant;
        systemState.resetSystemState();
      }
    } else {
      throw Exception(
          'additionalInformation is not Adult, Child or Infant on screenChangeButton call from Continue Button');
    }
    systemState.screenStatus = screenStatusEnum.monitorScreen;
    changeScenario(scenariosEnum.standardScenario);
    systemState.absAlarmFieldModel.evaluateActiveList();
    soundController.startSaturationHFSound();
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
    systemState.absAlarmFieldModel.evaluateActiveList();
    soundController.startSaturationHFSound();
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
    systemState.absAlarmFieldModel.evaluateActiveList();
    soundController.startSaturationHFSound();
    return Get.toNamed('/main_screen');
  }

  Future? patientSettingButton() {
    systemState.screenStatus = screenStatusEnum.patientSettingScreen;
    systemState.absAlarmFieldModel.closeOverlay();
    soundController.stop();
    return Get.offNamed('/start_screen');
  }

  Future? demoScreenButton() {
    systemState.absAlarmFieldModel.closeOverlay();
    soundController.stop();
    return Get.offNamed('/demo_screen');
  }

  void setSelectedToggleView(int index) {
    switch (index) {
      case 0:
        systemState.screenStatus = screenStatusEnum.monitorScreen;
        systemState.setSelectedToggleView([true, false, false]);
        systemState.absAlarmFieldModel.evaluateActiveList();
        break;
      case 1:
        systemState.screenStatus = screenStatusEnum.ventilationScreen;
        systemState.setSelectedToggleView([false, true, false]);
        systemState.absAlarmFieldModel.evaluateActiveList();
        break;
      case 2:
        systemState.screenStatus = screenStatusEnum.defibrillationScreen;
        systemState.setSelectedToggleView([false, false, true]);
        systemState.absAlarmFieldModel.evaluateActiveList();
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
    Get.find<SoundController>().stop();
    if (!modelManager.environmentValuesLoaded) {
      modelManager.loadDataModelEnvironmentValues();
    }
    return Get.offNamed('/alarm_limit_screen');
  }

  Future? scenarioMenuExitButton() {
    switch (systemState.screenStatus) {
      case screenStatusEnum.patientSettingScreen:
        soundController.stop();
        return Get.toNamed('/start_screen');
      case screenStatusEnum.monitorScreen:
        soundController.startSaturationHFSound();
        return Get.toNamed('/main_screen');
      case screenStatusEnum.ventilationScreen:
        soundController.startSaturationHFSound();
        return Get.toNamed('/main_screen');
      case screenStatusEnum.defibrillationScreen:
        soundController.startSaturationHFSound();
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
    systemState.absAlarmFieldModel.evaluateActiveList();
    soundController.startSaturationHFSound();
    systemState.resetSystemState();
    return Get.toNamed('/main_screen');
  }

  /// Behavior for smartAdjustementButton
  void smartAdjustmentButton(sensorEnumAbsolute sensorKey) {
    SmartAdjustmentMap boundaryAdjustmentMap = systemState.smartAdjustmentMap;
    DataModelAbsolute dataModel =
        Get.find<DataModelAbsolute>(tag: sensorKey.name);

    if (boundaryAdjustmentMap.map[sensorKey]!.lowerCounter.value >= 3) {
      boundaryAdjustmentMap.map[sensorKey]!.lowerCounter.value = 0;
      boundaryAdjustmentMap.map[sensorKey]!.dateTimeLower = DateTime.now();
      dataModel.setUpperAlarmBoundary(dataModel.lowerAlarmBound.value * 0.96);
      boundaryAdjustmentMap.calculatePressable(sensorKey);
    }
    if (boundaryAdjustmentMap.map[sensorKey]!.upperCounter.value >= 3) {
      boundaryAdjustmentMap.map[sensorKey]!.upperCounter.value = 0;
      boundaryAdjustmentMap.map[sensorKey]!.dateTimeUpper = DateTime.now();
      dataModel.setUpperAlarmBoundary(dataModel.upperAlarmBound.value * 1.04);
      boundaryAdjustmentMap.calculatePressable(sensorKey);
    }
  }
}
