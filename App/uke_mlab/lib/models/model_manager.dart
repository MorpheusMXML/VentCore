import 'package:get/get.dart';
import 'package:uke_mlab/models/model_absolute.dart';
import 'package:uke_mlab/models/model_graph.dart';
import 'package:uke_mlab/utilities/enums/sensor.dart';
import 'package:uke_mlab/utilities/enums/patient_type.dart';
import 'package:uke_mlab/models/model_absolute.dart';
import 'package:uke_mlab/models/model_graph.dart';
import 'package:uke_mlab/providers/alarm_controller.dart';

/// creates [DataModelAbsolute]s and [DataModelGraph]s and offers management operations for them
class ModelManager {
  /// [AlarmController] of the system (this is due to race conditions during creation)
  late final AlarmController _alarmController;

  /// signals whether style loading process is complete
  bool stylesTraitsLoaded = false;

  /// initializes for each entry of [sensorEnumAbsolute] a [DataModelAbsolute] and for each entry of [sensorEnumGraph] a [DataModelGraph]
  ModelManager() {
    for (var sensor in sensorEnumAbsolute.values) {
      Get.put(
          DataModelAbsolute(
            sensorKey: sensor,
            initialLowerBound: 0,
            initialUpperBound: 10,
          ),
          tag: sensor.name);
    }
    for (var sensor in sensorEnumGraph.values) {
      Get.put(
          DataModelGraph(
            sensorKey: sensor,
          ),
          tag: sensor.name);
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

  /// loads default alarm boundaries into [DataModelAbsolute]
  ///
  /// NOT TO BE CALLED WITH patientTypeEnum.none, since that has no predefined values
  /// [DataModelGraph] does not have boundary values due to the datas nature
  void loadPatientPresets(patientTypeEnum patientType) {
    if (!stylesTraitsLoaded) {
      loadDataModelEnvironmentValues();
    }

    for (var sensor in sensorEnumAbsolute.values) {
      DataModelAbsolute dataModel =
          Get.find<DataModelAbsolute>(tag: sensor.name);
      dataModel.resetDataModel();

      switch (patientType) {
        case patientTypeEnum.adult:
          dataModel.initialUpperBound = sensor.upperBound['adult'].toDouble();
          dataModel
              .setUpperAlarmBounadary(sensor.upperBound['adult'].toDouble());
          dataModel.initialLowerBound = sensor.lowerBound['adult'].toDouble();
          dataModel
              .setLowerAlarmBounadary(sensor.lowerBound['adult'].toDouble());
          break;
        case patientTypeEnum.child:
          dataModel.initialUpperBound = sensor.upperBound['child'].toDouble();
          dataModel
              .setUpperAlarmBounadary(sensor.upperBound['child'].toDouble());
          dataModel.initialLowerBound = sensor.lowerBound['child'].toDouble();
          dataModel
              .setLowerAlarmBounadary(sensor.lowerBound['child'].toDouble());
          break;
        case patientTypeEnum.infant:
          dataModel.initialUpperBound = sensor.upperBound['infant'].toDouble();
          dataModel
              .setUpperAlarmBounadary(sensor.upperBound['infant'].toDouble());
          dataModel.initialLowerBound = sensor.lowerBound['infant'].toDouble();
          dataModel
              .setLowerAlarmBounadary(sensor.lowerBound['infant'].toDouble());
          break;
        default:
          throw Exception(
              'loadingPatientPresets called with wrong parameter (most likely patientTypeEnum.none)');
      }
    }
  }

  void loadDataModelEnvironmentValues() {
    for (var sensor in sensorEnumAbsolute.values) {
      DataModelAbsolute dataModel =
          Get.find<DataModelAbsolute>(tag: sensor.name);
      dataModel.color = sensor.color;
      dataModel.displayString = sensor.displayString;
      dataModel.displayShortString = sensor.displayShortString;
      dataModel.abbreviation = sensor.abbreviation;
      dataModel.unit = sensor.unit;
      dataModel.floatRepresentation = sensor.floatRepresentation;
    }
    for (var sensor in sensorEnumGraph.values) {
      DataModelGraph dataModel = Get.find<DataModelGraph>(tag: sensor.name);
      dataModel.color = sensor.color;
      dataModel.xAxisTitle = sensor.xAxisUnit;
      dataModel.yAxisTitle = sensor.yAxisUnit;
      dataModel.graphTitle = sensor.graphTitle;
      dataModel.graphDataMaxLength = sensor.graphLength;
    }
  }

  void resetAllModels() {
    for (var sensor in sensorEnumAbsolute.values) {
      DataModelAbsolute dataModel =
          Get.find<DataModelAbsolute>(tag: sensor.name);
      dataModel.resetDataModel();
    }
    for (var sensor in sensorEnumGraph.values) {
      DataModelGraph dataModel = Get.find<DataModelGraph>(tag: sensor.name);
      dataModel.resetDataModel();
    }
  }
}
