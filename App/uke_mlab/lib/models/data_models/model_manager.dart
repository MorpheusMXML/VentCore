import 'package:get/get.dart';
import 'package:uke_mlab/models/data_models/model_absolute.dart';
import 'package:uke_mlab/models/data_models/model_graph.dart';
import 'package:uke_mlab/models/data_models/model_nibd.dart';

import 'package:uke_mlab/providers/alarm_controller.dart';

import 'package:uke_mlab/utilities/enums/sensor.dart';
import 'package:uke_mlab/utilities/enums/patient_type.dart';

/// Creates [DataModelAbsolute]s and [DataModelGraph]s and offers management operations for them.
///
/// {@category DataModels}
class ModelManager {
  /// [AlarmController] of the system (this is due to race conditions during creation)
  late final AlarmController _alarmController;

  /// signals whether style loading process is complete
  bool environmentValuesLoaded = false;

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
      if (sensor == sensorEnumGraph.nibd) {
        Get.put(
            DataModelNIBD(
              sensorKey: sensor,
            ),
            tag: sensor.name);
      } else {
        Get.put(
            DataModelGraph(
              sensorKey: sensor,
            ),
            tag: sensor.name);
      }
    }
  }

  /// registers [AlarmController] in [ModelManager]
  ///
  /// Only call this during system creation.
  void registerAlarmController(AlarmController newController) {
    _alarmController = newController;
    for (var sensor in sensorEnumAbsolute.values) {
      Get.find<DataModelAbsolute>(tag: sensor.name).alarmController = newController;
    }
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
    // set default environment values
    if (!environmentValuesLoaded) {
      loadDataModelEnvironmentValues();
    }

    // reset data models (cant be in second for loop because of standard values of ippv)
    for (var sensor in sensorEnumAbsolute.values) {
      Get.find<DataModelAbsolute>(tag: sensor.name).resetDataModel();
    }

    // set default boundaries
    for (var sensor in sensorEnumAbsolute.values) {
      DataModelAbsolute dataModel = Get.find<DataModelAbsolute>(tag: sensor.name);

      switch (patientType) {
        case patientTypeEnum.adult:
          dataModel.initialUpperBound = sensor.upperBound['adult'].toDouble();
          dataModel.setUpperAlarmBoundary(sensor.upperBound['adult'].toDouble());
          dataModel.initialLowerBound = sensor.lowerBound['adult'].toDouble();
          dataModel.setLowerAlarmBoundary(sensor.lowerBound['adult'].toDouble());
          break;
        case patientTypeEnum.child:
          dataModel.initialUpperBound = sensor.upperBound['child'].toDouble();
          dataModel.setUpperAlarmBoundary(sensor.upperBound['child'].toDouble());
          dataModel.initialLowerBound = sensor.lowerBound['child'].toDouble();
          dataModel.setLowerAlarmBoundary(sensor.lowerBound['child'].toDouble());
          break;
        case patientTypeEnum.infant:
          dataModel.initialUpperBound = sensor.upperBound['infant'].toDouble();
          dataModel.setUpperAlarmBoundary(sensor.upperBound['infant'].toDouble());
          dataModel.initialLowerBound = sensor.lowerBound['infant'].toDouble();
          dataModel.setLowerAlarmBoundary(sensor.lowerBound['infant'].toDouble());
          break;
        default:
          throw Exception('loadingPatientPresets called with wrong parameter (most likely patientTypeEnum.none)');
      }
    }
  }

  /// load corresponding environment values into all [DataModelAbsolute]s and [DataModelGraph]s
  void loadDataModelEnvironmentValues() {
    for (var sensor in sensorEnumAbsolute.values) {
      DataModelAbsolute dataModel = Get.find<DataModelAbsolute>(tag: sensor.name);
      dataModel.color = sensor.color;
      dataModel.displayString = sensor.displayString;
      dataModel.displayShortString = sensor.displayShortString;
      dataModel.abbreviation = sensor.abbreviation;
      dataModel.unit = sensor.unit;
      dataModel.floatRepresentation = sensor.floatRepresentation;
    }

    for (var sensor in sensorEnumGraph.values) {
      dynamic dataModel;
      if (sensor == sensorEnumGraph.nibd) {
        dataModel = Get.find<DataModelNIBD>(tag: sensor.name);
      } else {
        dataModel = Get.find<DataModelGraph>(tag: sensor.name);
      }
      dataModel.color = sensor.color;
      dataModel.xAxisTitle = sensor.xAxisUnit;
      dataModel.yAxisTitle = sensor.yAxisUnit;
      dataModel.graphTitle = sensor.graphTitle;
      dataModel.setGraphMaxLength(sensor.graphLength);
    }
    environmentValuesLoaded = true;
  }

  /// resets all known data models
  ///
  /// calls [DataModelAbsolute.resetDataModel] for all [sensorEnumAbsolute]s and [DataModelGraph.resetDataModel] for all [sensorEnumGraph]s
  void resetAllModels() {
    for (var sensor in sensorEnumAbsolute.values) {
      DataModelAbsolute dataModel = Get.find<DataModelAbsolute>(tag: sensor.name);
      dataModel.resetDataModel();
    }
    for (var sensor in sensorEnumGraph.values) {
      if (sensor == sensorEnumGraph.nibd) {
        DataModelNIBD dataModelNIBD = Get.find<DataModelNIBD>(tag: sensor.name);
        dataModelNIBD.resetDataModel();
      } else {
        DataModelGraph dataModel = Get.find<DataModelGraph>(tag: sensor.name);
        dataModel.resetDataModel();
      }
    }
  }
}
