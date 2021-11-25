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
      MapEntry(sensors.spo2, DataModel(0.obs, 0.obs, this))
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
  DataModel? getDataModel(sensors key) {
    return _activeModels[key];
  }

  AlarmController getAlarmController() {
    return _alarmController;
  }
}

//Historic data INCLUDES the presentData value at the end, is initiated with 100
//Alarm recognition is done in Alarm manager
class DataModel {
  late RxInt _upperAlarmBound;
  late RxInt _lowerAlarmBound;

  //Could have observable type to avoid type conversions, but why should these values be observable?
  late int _initialUpperBound;
  late int _initialLowerBound;

  Rx<ChartData> _presentData =
      ChartData(DateTime.now(), 0).obs; //TODO better/other initialisation?
  List<Rx<ChartData>> _historicalData =
      []; //growable list TODO: find out why compiler thinks final ist correct here, since pointer should change
  final int _historicalDataMaxLength = 100; //TODO could be a parameter
  late final ModelManager _modelManager;

  DataModel(RxInt upperBound, RxInt lowerBound, ModelManager modelManager) {
    _upperAlarmBound = upperBound;
    _initialUpperBound = upperBound.toInt();
    _lowerAlarmBound = lowerBound;
    _initialLowerBound = lowerBound.toInt();
    _modelManager = modelManager;
  }

  void updateValues(DateTime newTimeStamp, double newValue) {
    _presentData = ChartData(newTimeStamp, newValue).obs;
    _historicalData.add(_presentData);

    if (_historicalDataMaxLength < _historicalData.length) {
      _historicalData.removeAt(0);
    }
  }

  //informs alarmController about change via call
  void informAlarmController() {
    //TODO implememt
    //requires information about own state
  }

  boundaryState evaluateBoundarieViolation() {
    if (_presentData.value.getValue() > _upperAlarmBound.toDouble()) {
      return boundaryState.upperBoundaryViolated;
    } else if (_presentData.value.getValue() < _lowerAlarmBound.toDouble()) {
      return boundaryState.lowerBoundaryViolated;
    } else {
      return boundaryState.inBoundaries;
    }
  }

  void resetDataModel() {
    _upperAlarmBound = RxInt(_initialUpperBound);
    _lowerAlarmBound = RxInt(_initialLowerBound);
    _presentData = ChartData(DateTime.now(), 0).obs;
    _historicalData.clear();
  }

  void setUpperAlarmBoundary(int newBoundary) {
    _upperAlarmBound = RxInt(newBoundary);
  }

  void setLowerAlarmBoundary(int newBoundary) {
    _lowerAlarmBound = RxInt(newBoundary);
  }

  Rx<ChartData> getPresenData() {
    return _presentData;
  }

  List<Rx<ChartData>> getHistoricalData() {
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
