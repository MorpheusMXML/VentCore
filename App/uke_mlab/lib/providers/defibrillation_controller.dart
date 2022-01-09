import 'package:get/get.dart';

class DefibrillationController extends GetxController {
  RxString selected = 'Auto'.obs;

  void setSelected(String name) {
    selected.value = name;
  }
}
