import 'package:get/get.dart';
import 'package:uke_mlab/models/enums.dart';
import 'package:uke_mlab/utilities/alarm_controller.dart';

class ModelManager {
  final Map<sensors, DataModel> _activeModels = {};
  //TODO get standard values as Adult values, maybe from a respective JSON?
  //Add aditional data entries as soon as model data is required
  late final _initialValues;

  late final AlarmController _alarmController;

  ModelManager() {
    _initialValues = {
      MapEntry(sensors.heartFrequency, DataModel(0.obs, 0.obs, this)),
      MapEntry(sensors.spo2, DataModel(0.obs, 0.obs, this)),
      MapEntry(sensors.pulse, DataModel(0.obs, 0.obs, this)),
      MapEntry(sensors.breathFrequency, DataModel(0.obs, 0.obs, this))
    };
    _activeModels.addEntries(_initialValues);
  }

  void resetModels() {
    _activeModels.forEach((key, value) => value.resetDataModel());
  }

  void registerAlarmController(AlarmController newController) {
    _alarmController = newController;
  }

  //Returns null if no key matched, use null exception if used
  DataModel getDataModel(sensors key) {
    if (_activeModels[key] != null) {
      return _activeModels[key]!;
    } else {
      throw ArgumentError("No mapping for sensor key " + key.toString());
    }
  }

  AlarmController getAlarmController() {
    return _alarmController;
  }
}

//Historic data INCLUDES the presentData value at the end, is initiated with 100
//Alarm recognition is done in Alarm manager
class DataModel extends GetxController {
  late RxInt _upperAlarmBound;
  late RxInt _lowerAlarmBound;

  //Could have observable type to avoid type conversions, but why should these values be observable?
  late int _initialUpperBound;
  late int _initialLowerBound;

  Rx<ChartData> presentData = ChartData(DateTime.now(), 0).obs;
  final _historicalData = []
      .obs; //growable list TODO: find out why compiler thinks final ist correct here, since pointer could change
  final int _historicalDataMaxLength = 100; //TODO should be a parameter
  late final ModelManager _modelManager;

  DataModel(RxInt upperBound, RxInt lowerBound, ModelManager modelManager) {
    _upperAlarmBound = upperBound;
    _initialUpperBound = upperBound.toInt();
    _lowerAlarmBound = lowerBound;
    _initialLowerBound = lowerBound.toInt();
    _modelManager = modelManager;
  }

  //updates a value, puts current tuple into historical list (needed for histories) + forces getx to do an update
  void updateValues(DateTime newTimeStamp, double newValue) {
    presentData = ChartData(newTimeStamp, newValue).obs;
    _historicalData.add(presentData);

    if (_historicalDataMaxLength < _historicalData.length) {
      _historicalData.removeAt(0);
    }
    update();
  }

  //informs alarmController about change via call
  void informAlarmController() {
    //TODO implememt
    //requires information about own state
  }

  boundaryState evaluateBoundarieViolation() {
    if (presentData.value.getValue() > _upperAlarmBound.toDouble()) {
      return boundaryState.upperBoundaryViolated;
    } else if (presentData.value.getValue() < _lowerAlarmBound.toDouble()) {
      return boundaryState.lowerBoundaryViolated;
    } else {
      return boundaryState.inBoundaries;
    }
  }

  void resetDataModel() {
    _upperAlarmBound = RxInt(_initialUpperBound);
    _lowerAlarmBound = RxInt(_initialLowerBound);
    presentData = ChartData(DateTime.now(), 0).obs;
    _historicalData.clear();
  }

  void setUpperAlarmBoundary(int newBoundary) {
    _upperAlarmBound = RxInt(newBoundary);
  }

  void setLowerAlarmBoundary(int newBoundary) {
    _lowerAlarmBound = RxInt(newBoundary);
  }

  Rx<ChartData> getPresenData() {
    return presentData;
  }

  getHistoricalData() {
    return _historicalData;
  }

  RxInt getUpperAlarmBound() {
    return _upperAlarmBound;
  }

  RxInt getLowerAlarmBound() {
    return _lowerAlarmBound;
  }
}

// Construct a new data entry tuple
class ChartData {
  final DateTime _time;
  final double _value;

  ChartData(this._time, this._value);

  DateTime getTime() {
    return _time;
  }

  double getValue() {
    return _value;
  }
}
