import 'package:uke_mlab/models/model.dart';

class AlarmController {
  late ModelManager _modelManager;

  AlarmController(ModelManager modelManager) {
    _modelManager = modelManager;
    _modelManager.registerAlarmController(this);
  }
}
