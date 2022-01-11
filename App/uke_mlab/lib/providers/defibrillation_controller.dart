import 'dart:async';

import 'package:get/get.dart';

class DefibrillationController extends GetxController {
  RxString selectedImpedanceButton = 'Low'.obs;
  RxString selectedDefiButton = 'Auto'.obs;
  RxString selectedSynchronicityButton = 'Sync'.obs;

  RxBool metronomeOn = false.obs;
  RxString loaded = 'Loaded'.obs;

  RxInt shockPower = 200.obs;
  RxString systemDiagnosis = 'Placeholder Diagnosis'.obs;

  RxString lastShock = ''.obs;
  RxInt numberOfShocks = 0.obs;
  Rx<Stopwatch> timer = Stopwatch().obs;

  void toggleLoaded(String value) async {
    if (loaded.value == 'Shock') {
      numberOfShocks++;
    } else {
      loaded.value = 'Loading';
      await Future.delayed(const Duration(seconds: 2));
    }

    loaded.value = value;
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
