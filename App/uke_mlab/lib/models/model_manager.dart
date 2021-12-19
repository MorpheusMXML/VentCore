import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/models/enums.dart';
import 'package:uke_mlab/models/system_state.dart';
import 'package:uke_mlab/models/model.dart';
import 'package:uke_mlab/utilities/alarm_controller.dart';

class ModelManager {
  late final AlarmController _alarmController;
  late final Map<String, dynamic> defaultValues;

  ModelManager() {
    for (var sensor in sensorEnum.values) {
      //TODO read standard values from somewhere
      Get.put(DataModel(sensor, 10, 0, this), tag: sensor.toString());
    }
    onInit();
    //loadPatientPresets(patientTypeEnum.adult);
  }

  void onInit() async {
    var defaultString =
        await rootBundle.loadString('assets/jsons/default_boundaries.json');
    defaultValues = await jsonDecode(defaultString.toString());
  }

  void registerAlarmController(AlarmController newController) {
    _alarmController = newController;
  }

  AlarmController getAlarmController() {
    return _alarmController;
  }

  //Loads default valus for alarm boundaries to DataModel if patientType changed
  //NOT TO BE CALLED WITH patientTypeEnum.none, since that has no pre defined values
  void loadPatientPresets(patientTypeEnum patientType) {
    for (var sensor in sensorEnum.values) {
      if (defaultValues.containsKey(sensor.toString())) {
        DataModel dataModel = Get.find<DataModel>(tag: sensor.toString());

        dataModel.resetDataModel();
        switch (patientType) {
          case patientTypeEnum.adult:
            dataModel.initialUpperBound =
                defaultValues[sensor.toString()]["adult"]["upperBound"];
            dataModel.upperAlarmBound.value =
                defaultValues[sensor.toString()]["adult"]["upperBound"];
            dataModel.initialLowerBound =
                defaultValues[sensor.toString()]["adult"]["lowerBound"];
            dataModel.lowerAlarmBound.value =
                defaultValues[sensor.toString()]["adult"]["lowerBound"];
            break;
          case patientTypeEnum.child:
            dataModel.initialUpperBound =
                defaultValues[sensor.toString()]["child"]["upperBound"];
            dataModel.upperAlarmBound.value =
                defaultValues[sensor.toString()]["child"]["upperBound"];
            dataModel.initialLowerBound =
                defaultValues[sensor.toString()]["child"]["lowerBound"];
            dataModel.lowerAlarmBound.value =
                defaultValues[sensor.toString()]["child"]["lowerBound"];
            break;
          case patientTypeEnum.infant:
            dataModel.initialUpperBound =
                defaultValues[sensor.toString()]["infant"]["upperBound"];
            dataModel.upperAlarmBound.value =
                defaultValues[sensor.toString()]["infant"]["upperBound"];
            dataModel.initialLowerBound =
                defaultValues[sensor.toString()]["infant"]["lowerBound"];
            dataModel.lowerAlarmBound.value =
                defaultValues[sensor.toString()]["infant"]["lowerBound"];
            break;
          default:
            throw Exception(
                "loadingPatientPresets called with wrong parameter (most likeley patientTypeEnum.none)");
        }
      } else {
        printInfo(
            info: "WARNING: Sensor " +
                sensor.toString() +
                " has no default Values in default_boundaries.json, please add those.");
      }
    }
  }
}
