import 'package:get/get.dart';
import 'package:uke_mlab/utilities/enums/sensor.dart';
import 'package:uke_mlab/utilities/enums/patient_type.dart';
import 'package:uke_mlab/models/model.dart';
import 'package:uke_mlab/providers/alarm_controller.dart';

/// creates [DataModel]s and offers management operations
class ModelManager {
  /// [AlarmController] of the system (this is due to race conditions during creation)
  late final AlarmController _alarmController;

  /// signals whether style loading process is complete
  bool stylesTraitsLoaded = false;

  /// initializes for each entry of [sensorEnum] a [DataModel]
  ModelManager() {
    for (var sensor in sensorEnum.values) {
      Get.put(DataModel(sensor, 10, 0, this), tag: sensor.name);
    }
  }

  /// registers [AlarmController] in [ModelManager]
  ///
  /// only to be called during system creation
  void registerAlarmController(AlarmController newController) {
    _alarmController = newController;
  }

  /// returns registered [AlarmController]
  AlarmController getAlarmController() {
    return _alarmController;
  }

  /// loads default alarm boundaries into [DataModel]
  ///
  /// NOT TO BE CALLED WITH patientTypeEnum.none, since that has no predefined values
  void loadPatientPresets(patientTypeEnum patientType) {
    if (!stylesTraitsLoaded) {
      loadStyleInfo();
    }

    for (var sensor in sensorEnum.values) {
      DataModel dataModel = Get.find<DataModel>(tag: sensor.name);
      dataModel.resetDataModel();

      switch (patientType) {
        case patientTypeEnum.adult:
          dataModel.initialUpperBound = sensor.upperBound['adult'];
          dataModel.upperAlarmBound.value = sensor.upperBound['adult'];
          dataModel.initialLowerBound = sensor.lowerBound['adult'];
          dataModel.lowerAlarmBound.value = sensor.lowerBound['adult'];
          break;
        case patientTypeEnum.child:
          dataModel.initialUpperBound = sensor.upperBound['child'];
          dataModel.upperAlarmBound.value = sensor.upperBound['child'];
          dataModel.initialLowerBound = sensor.lowerBound['child'];
          dataModel.lowerAlarmBound.value = sensor.lowerBound['child'];
          break;
        case patientTypeEnum.infant:
          dataModel.initialUpperBound = sensor.upperBound['infant'];
          dataModel.upperAlarmBound.value = sensor.upperBound['infant'];
          dataModel.initialLowerBound = sensor.lowerBound['infant'];
          dataModel.lowerAlarmBound.value = sensor.lowerBound['infant'];
          break;
        default:
          throw Exception(
              'loadingPatientPresets called with wrong parameter (most likely patientTypeEnum.none)');
      }
    }
  }

  void loadStyleInfo() {
    for (var sensor in sensorEnum.values) {
      DataModel dataModel = Get.find<DataModel>(tag: sensor.name);
      dataModel.color = sensor.color;
      dataModel.displayString = sensor.displayString;
      dataModel.displayShortString = sensor.displayShortString;
      dataModel.abbreviation = sensor.abbreviation;
    }
  }

  void resetAllModels() {
    for (var sensor in sensorEnum.values) {
      DataModel dataModel = Get.find<DataModel>(tag: sensor.name);
      dataModel.resetDataModel();
    }
  }
}
