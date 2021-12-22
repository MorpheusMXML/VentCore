import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/models/enums.dart';
import 'package:uke_mlab/models/model.dart';
import 'package:uke_mlab/utilities/alarm_controller.dart';

class ModelManager {
  late final AlarmController _alarmController;
  late final Map<String, dynamic> defaultValues;

  bool stylesTraitsLoaded = false;

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
        await rootBundle.loadString('assets/jsons/sensor_default_values.json');
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
    if (!stylesTraitsLoaded) {
      loadStyleInfo();
    }

    for (var sensor in sensorEnum.values) {
      DataModel dataModel = Get.find<DataModel>(tag: sensor.toString());

      dataModel.resetDataModel();

      if (defaultValues.containsKey(sensor.toString())) {
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
                " has no default Values for AlarmBoundaries.");
      }
    }
  }

  void loadStyleInfo() {
    for (var sensor in sensorEnum.values) {
      if (defaultValues.containsKey(sensor.toString())) {
        DataModel dataModel = Get.find<DataModel>(tag: sensor.toString());
        dataModel.color =
            Color(int.parse(defaultValues[sensor.toString()]["color"]));
        dataModel.title = defaultValues[sensor.toString()]["title"];
        dataModel.miniTitle = defaultValues[sensor.toString()]["minititle"];
        // print(dataModel.title + ": " + dataModel.color.toString());
      } else {
        printInfo(
            info: "WARNING: Sensor " +
                sensor.toString() +
                " has no default Values for style data.");
      }
    }
    stylesTraitsLoaded = true;
  }
}
