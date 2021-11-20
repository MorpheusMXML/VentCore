import 'package:get/get.dart';

class ModelManager {
  final Map<String, DataModel> _activeModels = {};

  ModelManager() {
    //TODO get standard values as Adult values
    //TODO better keys than names
    //Add aditional data entries as soon as model data is required
    _activeModels.addEntries({
      MapEntry("HeartFrequency", DataModel(0.obs, 0.obs)),
      MapEntry("SpO2", DataModel(0.obs, 0.obs))
    });
  }

  //TODO better keys, see above
  //Returns null if no key matched, use null exception if used
  DataModel? getDataModel(String key) {
    return _activeModels[key];
  }
}

// TODO factory for objects

//Historic data INCLUDES the presentData value at the end, is initiated with 100
//Alarm recognition is done in Alarm manager
class DataModel {
  late RxInt _upperAlarmBound;
  late RxInt _lowerAlarmBound;
  Rx<ChartData> _presentData =
      ChartData(DateTime.now(), 0).obs; //TODO better/other initialisation?
  List<Rx<ChartData>> _historicalData =
      []; //growable list TODO: find out why compiler thinks final ist correct here, since pointer should change
  final int _historicalDataMaxLength = 100; //TODO could be a parameter

  DataModel(RxInt upperBound, RxInt lowerBound) {
    _upperAlarmBound = upperBound;
    _lowerAlarmBound = lowerBound;
  }

  void updateValues(DateTime newTimeStamp, double newValue) {
    _presentData = ChartData(newTimeStamp, newValue).obs;
    _historicalData.add(_presentData);

    //Check whether MaxLength < list length, if so, drop beginning
    if (_historicalDataMaxLength < _historicalData.length) {
      _historicalData.removeAt(0);
    }
  }

  void updateUpperAlarmBoundary(int newBoundary) {
    _upperAlarmBound = newBoundary as RxInt;
  }

  void updateLowerAlarmBoundary(int newBoundary) {
    _lowerAlarmBound = newBoundary as RxInt;
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
