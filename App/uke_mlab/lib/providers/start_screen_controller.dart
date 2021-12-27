import 'package:get/get.dart';

class StartScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(StartScreenController());
  }
}

class StartScreenController extends GetxController {
  RxString selectedString = ''.obs;
  RxDouble weightValue = 75.0.obs;
  RxDouble heightValue = 175.0.obs;

  RxBool isPopupVisible = false.obs;

  void settingsButton(String name) {
    switch (name) {
      case 'Child':
        selectedString.value = name;
        weightValue.value = 45.0;
        heightValue.value = 155.0;
        break;
      case 'Infant':
        selectedString.value = name;
        weightValue.value = 10.0;
        heightValue.value = 85.0;
        break;
      default:
        selectedString.value = name;
        weightValue.value = 75.0;
        heightValue.value = 175.0;
        break;
    }

    isPopupVisible.value = true;
  }

  setValue(newValue, name) {
    switch (name) {
      case 'Height':
        heightValue.value = newValue;
        break;
      default:
        weightValue.value = newValue;
        break;
    }
  }
}
