import 'package:get/get.dart';

class ActiveModels {
  //TODO: use a datastructure to monitor active models
}

// TODO factory for objects

class DataObject {
  RxInt upperAlarmBound = 0.obs;
  RxInt lowerAlarmBound = 0.obs;
  var valuesPlaceholder = 0
      .obs; // TODO Datastructure holding instead of placeholder, discuss with group

  DataObject(int upperBound, int lowerBound) {
    upperAlarmBound = upperBound as RxInt;
    lowerAlarmBound = lowerBound as RxInt;
  }

  void updateValues(int value) {
    valuesPlaceholder =
        value as RxInt; //TODO add Value to data structure from API/input
  }

  //TODO replace
  RxInt getValues() {
    return valuesPlaceholder;
  }

  // TODO checkBoundaries and following could also be done in alarmManager
  void checkBoundaries() {
    if ((upperAlarmBound as int) <
        (valuesPlaceholder as int)) //TODO replace valuesPlaceholder
    {
      sendAlarm(valuesPlaceholder as int, true);
    } else if ((valuesPlaceholder as int) <
        (lowerAlarmBound as int)) //TODO replace valuesPlaceholder
    {
      sendAlarm(valuesPlaceholder as int, false);
    } else {
      stopAlarm();
    }
  }

  // up = true: upper bound failed
  void sendAlarm(int placeholder, bool up) {
    //TODO send an alarm to alarm manager once designed and implemented
  }

  void stopAlarm() {
    //TODO send a stop alarm signal to alarm manager once designed and implemented
  }
}
