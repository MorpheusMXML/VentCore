import 'package:get/get.dart';

class StartScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(StartScreenController());
  }
}

class StartScreenController extends GetxController {
  RxString selected = "Adult".obs;

  void settingsButton(String name) {
    selected = name.obs;
    update();
  }
}
