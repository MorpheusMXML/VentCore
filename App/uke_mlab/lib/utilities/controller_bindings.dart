import 'package:get/get.dart';
import 'package:uke_mlab/providers/defibrillation_controller.dart';

import 'package:uke_mlab/providers/start_screen_controller.dart';
import 'package:uke_mlab/providers/screen_controller.dart';

class ControllerBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(StartScreenController());
    Get.put(DefibrillationController());
  }
}
