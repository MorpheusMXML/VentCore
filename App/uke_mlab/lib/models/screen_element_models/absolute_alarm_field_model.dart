import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/utilities/enums/sensor.dart';

class AbsAlarmFieldModel extends GetxController {
  OverlayEntry? entry;
  RxBool listExpanded = false.obs;

  Set<sensorEnumAbsolute> monitorSet = {
    sensorEnumAbsolute.diaAbsolute,
    sensorEnumAbsolute.sysAbsolute,
    sensorEnumAbsolute.tempAbsolute,
    sensorEnumAbsolute.pulse
  };
  Set<sensorEnumAbsolute> ventilationSet = {
    sensorEnumAbsolute.breathfrequency,
    sensorEnumAbsolute.mve,
    sensorEnumAbsolute.hfAbsolute
  };
  Set<sensorEnumAbsolute> defiSet =
      {}; // will be unused at the moment, but here for completion

}
