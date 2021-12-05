import 'package:get/get.dart';

class StartScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(StartScreenController());
  }
}

class StartScreenController extends GetxController {
  RxString selectedString = "".obs;

  void settingsButton(String name) {
    selectedString = name.obs;
    update();
  }
}
