import 'package:get/get.dart';
import 'package:uke_mlab/utilities/enums/sensor.dart';

class SmartAdjustmentMap {
  final Map<sensorEnumAbsolute, SmartAdjustmentMapEntry> map =
      <sensorEnumAbsolute, SmartAdjustmentMapEntry>{};

  SmartAdjustmentMap() {
    for (var sensorKey in sensorEnumAbsolute.values) {
      map[sensorKey] =
          SmartAdjustmentMapEntry(DateTime.now(), DateTime.now(), 0.obs, 0.obs);
    }
  }

  void updateLowerCounter(sensorEnumAbsolute sensorKey) {
    DateTime dateTime = DateTime.now();
    if (dateTime.difference(map[sensorKey]!.dateTimeLower).inSeconds <= 30) {
      map[sensorKey]!.lowerCounter.value++;
      map[sensorKey]!.dateTimeLower = dateTime;
    } else {
      map[sensorKey]!.lowerCounter.value = 0;
      map[sensorKey]!.dateTimeLower = dateTime;
    }
    calculatePressable(sensorKey);
  }

  void updateUpperCounter(sensorEnumAbsolute sensorKey) {
    DateTime dateTime = DateTime.now();
    if (dateTime.difference(map[sensorKey]!.dateTimeUpper).inSeconds <= 30) {
      map[sensorKey]!.upperCounter.value++;
      map[sensorKey]!.dateTimeUpper = dateTime;
    } else {
      map[sensorKey]!.upperCounter.value = 0;
      map[sensorKey]!.dateTimeUpper = dateTime;
    }
    calculatePressable(sensorKey);
  }

  void calculatePressable(sensorEnumAbsolute sensorKey) {
    if (map[sensorKey]!.lowerCounter.value >= 3 ||
        map[sensorKey]!.upperCounter.value >= 3) {
      map[sensorKey]!.isPressable.value = true;
    }
    map[sensorKey]!.isPressable.value = false;
  }
}

class SmartAdjustmentMapEntry {
  DateTime dateTimeLower;
  DateTime dateTimeUpper;
  RxInt lowerCounter;
  RxInt upperCounter;
  RxBool isPressable = false.obs;

  SmartAdjustmentMapEntry(
    this.dateTimeLower,
    this.dateTimeUpper,
    this.lowerCounter,
    this.upperCounter,
  );
}
