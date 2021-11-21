import 'package:get/get.dart';
import 'package:uke_mlab/models/model.dart';

class AlarmNotifier {
  late ModelManager _modelManager;

  AlarmNotifier(ModelManager modelManager) {
    _modelManager = modelManager;
  }
}
