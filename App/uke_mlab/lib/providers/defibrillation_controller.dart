import 'package:get/get.dart';

class DefibrillationController extends GetxController {
  RxString selectedImpedanceButton = 'Low'.obs;
  RxString selectedDefiButton = 'Auto'.obs;
  RxString selectedSynchronicityButton = 'Sync'.obs;

  RxBool metronomeOn = false.obs;
  RxBool loaded = true.obs;

  void toggleLoaded() {
    loaded.toggle();
  }

  void toggleMetronome(bool changed) {
    metronomeOn.value = changed;
  }

  void setSelectedImpedanceButton(String name) {
    selectedImpedanceButton.value = name;
  }

  void setSelectedDefiButton(String name) {
    selectedDefiButton.value = name;
  }

  void setSelectedSynchronicityButton(String name) {
    selectedSynchronicityButton.value = name;
  }
}
