import 'package:get/get.dart';

class ToggleBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ToggleController());
  }
}

class ToggleController extends GetxController {
  RxList<bool> isSelected = [true, false, false].obs;

  void setSelected(int index) {
    for (var i = 0; i <= isSelected.length - 1; i++) {
      index == i ? isSelected[i] = true : isSelected[i] = false;
    }
  }
}
