import 'package:get/get.dart';
import 'package:uke_mlab/models/screen_element_models/general_alarms.dart';
import 'package:uke_mlab/providers/defibrillation_controller.dart';

import 'package:uke_mlab/providers/start_screen_controller.dart';
import 'package:uke_mlab/providers/screen_controller.dart';

//TODO: COMMENTARY
class ControllerBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(StartScreenController());
    Get.put(DefibrillationController());
    Get.put(ScreenController());
    Get.put(GeneralAlarms());
  }
}
