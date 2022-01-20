import 'dart:async';

import 'package:get/get.dart';
import 'package:uke_mlab/widgets/defibrillation_mode/load_shock_button.dart';

class DefibrillationController extends GetxController {
  Stopwatch timerWatch = Stopwatch();
  Stopwatch lastWatch = Stopwatch();

  Timer? timerTimer;
  Timer? lastTimer;

  int startTimerCount = 0;
  int lastTimerCount = 0;

  RxString startTimerString = ''.obs;
  RxString lastTimerString = 'none'.obs;

  RxString selectedImpedanceButton = 'OK'.obs;
  RxString selectedDefiButton = 'Auto'.obs;
  RxString selectedSynchronicityButton = 'Sync'.obs;

  RxBool metronomeOn = true.obs;
  bool isReadyToShock = false;
//TODO: Get Shock Power from preset Adult, CHild, Infant
  RxInt shockPower = 200.obs;
  RxString systemDiagnosis = 'Placeholder Diagnosis'.obs;

  RxInt numberOfShocks = 0.obs;

  void startTimerWatch() {
    timerTimer?.cancel();
    timerWatch.start();
    timerTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      startTimerCount++;
      startTimerString.value = timerToString(startTimerCount);
    });
  }

  void startLastWatch() {
    if (lastWatch.isRunning) {
      lastTimer?.cancel();
      lastWatch.stop();
      lastTimerCount = 0;
      lastTimerString.value = timerToString(lastTimerCount);
    }
    lastWatch.start();

    lastTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      lastTimerCount++;
      lastTimerString.value = timerToString(lastTimerCount);
    });
  }

  String timerToString(int seconds) {
    Duration duration = Duration(seconds: seconds);

    String twoDigits(int n) => '$n'.padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return '$twoDigitMinutes:$twoDigitSeconds';
  }

  void toggleMetronome(bool changed) {
    metronomeOn.value = changed;
  }

  void setSelectedImpedanceButton(String name) {
    selectedImpedanceButton.value = name;
  }

  void setSelectedDefiButton(String name) {
    if (name == 'Auto') {
      toggleMetronome(true);
      setSelectedImpedanceButton('OK');
      setSelectedSynchronicityButton('Sync');
    }
    selectedDefiButton.value = name;
  }

  void setSelectedSynchronicityButton(String name) {
    selectedSynchronicityButton.value = name;
  }
}
