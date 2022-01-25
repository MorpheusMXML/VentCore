import 'package:get/get.dart';
import 'package:uke_mlab/models/data_models/model_absolute.dart';
import 'package:uke_mlab/utilities/enums/sensor.dart';

/// holds representation of information for all [DataModelAbsolute]s for the smart Adjustment feature of the alarm boundaries
class SmartAdjustmentMap {
  /// maps an [SmartAdjustmentMapEntry]
  final Map<sensorEnumAbsolute, SmartAdjustmentMapEntry> map =
      <sensorEnumAbsolute, SmartAdjustmentMapEntry>{};
  final int allowedTimeDifference = 30;
  final int minimalRepetition = 3;

  /// initializes [map] with a map over all [sensorEnumAbsolute] with a [SmartAdjustmentMapEntry]
  ///
  /// Times are set to now, counter values are 0 => Buttons not pressable
  SmartAdjustmentMap() {
    for (var sensorKey in sensorEnumAbsolute.values) {
      map[sensorKey] =
          SmartAdjustmentMapEntry(DateTime.now(), DateTime.now(), 0.obs, 0.obs);
    }
  }

  /// updates the [SmartAdjustmentMapEntry.lowerCounter] belonging to [sensorKey]
  ///
  /// if in [allowedTimeDifference] the counter is updated. If not it is set to 0
  /// [calculatePressable] is called afterwards either way
  void updateLowerCounter(sensorEnumAbsolute sensorKey) {
    DateTime dateTime = DateTime.now();
    if (dateTime.difference(map[sensorKey]!.dateTimeLower).inSeconds <=
        allowedTimeDifference) {
      map[sensorKey]!.lowerCounter.value++;
      map[sensorKey]!.dateTimeLower = dateTime;
    } else {
      map[sensorKey]!.lowerCounter.value = 0;
      map[sensorKey]!.dateTimeLower = dateTime;
    }
    calculatePressable(sensorKey);
  }

  /// updates the [SmartAdjustmentMapEntry.upperCounter] belonging to [sensorKey]
  ///
  /// if in [allowedTimeDifference] the counter is updated. If not it is set to 0
  /// [calculatePressable] is called afterwards either way
  void updateUpperCounter(sensorEnumAbsolute sensorKey) {
    DateTime dateTime = DateTime.now();
    if (dateTime.difference(map[sensorKey]!.dateTimeUpper).inSeconds <=
        allowedTimeDifference) {
      map[sensorKey]!.upperCounter.value++;
      map[sensorKey]!.dateTimeUpper = dateTime;
    } else {
      map[sensorKey]!.upperCounter.value = 0;
      map[sensorKey]!.dateTimeUpper = dateTime;
    }
    calculatePressable(sensorKey);
  }

  /// calculates whether the smart adjustment button belonging to [sensorKey] is currently pressable
  ///
  /// sets corresponding [SmartAdjustmentMapEntry.isPressable]
  void calculatePressable(sensorEnumAbsolute sensorKey) {
    if (map[sensorKey]!.lowerCounter.value >= minimalRepetition ||
        map[sensorKey]!.upperCounter.value >= minimalRepetition) {
      map[sensorKey]!.isPressable.value = true;
    } else {
      map[sensorKey]!.isPressable.value = false;
    }
  }
}

/// entry for [SmartAdjustmentMap.map]
///
/// contains a [DateTime] for the last update of the last time a lower boundary violation and an upper boundary violation was triggered each
/// contains information whether the corresponding button is pressable
/// contains a counter how many times the lower or upper boundary was violated in [SmartAdjustmentMap.allowedTimeDifference]
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
