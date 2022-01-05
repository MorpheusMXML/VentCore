import 'package:get/get.dart';

import 'package:uke_mlab/providers/start_screen_controller.dart';
import 'package:uke_mlab/providers/toggle_controller.dart';
import 'package:uke_mlab/utilities/screen_controller.dart';

class ControllerBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(StartScreenController());
    Get.put(ScreenController());
    Get.put(ToggleController());
  }
}
