import 'package:get/get.dart';

class StartScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(StartScreenController());
  }
}

class StartScreenController extends GetxController {
  RxString selectedString = "".obs;
  RxDouble weightValue = 20.0.obs;
  RxDouble heightValue = 20.0.obs;

  void settingsButton(String name) {
    selectedString = name.obs;
    update();
  }

  setValue(newValue, name) {
    switch (name) {
      case "Height":
        heightValue.value = newValue;
        break;
      default:
        weightValue.value = newValue;
    }
  }
}
