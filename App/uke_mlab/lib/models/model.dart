import 'package:get/get.dart';
import 'package:uke_mlab/models/enums.dart';
import 'package:uke_mlab/models/system_state.dart';
import 'package:uke_mlab/models/model_manager.dart';
import 'package:uke_mlab/utilities/alarm_controller.dart';

/// graphData INCLUDES the singleData value at the end
/// Alarm evaluation is done in alarm_controller
/// graphDataMaxLength is initialized with 100, can be manipulated
class DataModel extends GetxController {
  late final sensorEnum sensorKey;

  final RxInt upperAlarmBound = 0.obs;
  final RxInt lowerAlarmBound = 0.obs;

  late int initialUpperBound;
  late int initialLowerBound;

  late final Rx<ChartData> singleData;

  final RxList<ChartData> graphData =
      <ChartData>[].obs; //variable list, maybe fill up to _graphDataMaxLength?
  int graphDataMaxLength = 100;

  late final ModelManager modelManager;
  final SystemState _systemState = Get.find<SystemState>();

  DataModel(sensorEnum initSensorKey, int upperBound, int lowerBound,
      ModelManager modelManager) {
    sensorKey = initSensorKey;

    initialUpperBound = upperBound;
    initialLowerBound = lowerBound;

    upperAlarmBound.value = upperBound;
    lowerAlarmBound.value = lowerBound;

    modelManager = modelManager;

    singleData = ChartData(DateTime.now(), 0.0, 0).obs;
  }

  // updates singleDate with a new value, puts singleData at the end of the list
  // if graphData would exceed maxLenght, remove first (oldest) element
  // graphData is sorted by oldest at pos 0 to latest element
  void updateValues(double newValue) {
    singleData.value =
        ChartData(DateTime.now(), newValue, singleData.value.counter + 1);
    if (graphData.length + 1 > graphDataMaxLength) {
      graphData.removeAt(0);
    }
    graphData.add(singleData.value);
    print(graphData.length.toString());

    //evaluates whether update violated alarm boundaries or returns into boundaries
    if (singleData.value.value > upperAlarmBound.value) {
      evaluateBoundaryChange(boundaryStateEnum.upperBoundaryViolated);
    } else if (singleData.value.value < lowerAlarmBound.value) {
      evaluateBoundaryChange(boundaryStateEnum.lowerBoundaryViolated);
    } else {
      evaluateBoundaryChange(boundaryStateEnum.inBoundaries);
    }
  }

  void evaluateBoundaryChange(boundaryState) {
    if (_systemState.violationStates[sensorKey] != boundaryState) {
      _systemState.violationStates[sensorKey] = boundaryState;
      informAlarmController(boundaryState);
    }
  }

  //informs alarmController about change via call
  void informAlarmController(boundaryStateEnum boundaryState) {
    //TODO implememt instead of just printing
    print("$sensorKey had boundary change to $boundaryState");
    //requires information about own state
  }

  void resetDataModel() {
    // reset alarm boundaries
    upperAlarmBound.value = initialUpperBound;
    lowerAlarmBound.value = initialLowerBound;
    //reset singleData to 0 entry
    singleData.value = ChartData(DateTime.now(), 0.0, 0);
    //clear historical data
    graphData.clear();
  }
}

// Construct a new data entry tuple
class ChartData {
  final DateTime time;
  final double value;
  final int counter;

  ChartData(this.time, this.value, this.counter);
}
