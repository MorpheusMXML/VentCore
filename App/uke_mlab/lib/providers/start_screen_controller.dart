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
    switch (name) {
      case "Child":
        selectedString.value = name;
        weightValue.value = 47.0;
        heightValue.value = 156.0;
        break;
      case "Infant":
        selectedString.value = name;
        weightValue.value = 10.0;
        heightValue.value = 85.0;
        break;
      default:
        selectedString.value = name;
        weightValue.value = 77.0;
        heightValue.value = 172.0;
    }
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
