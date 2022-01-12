import 'dart:async';

import 'package:get/get.dart';

class DefibrillationController extends GetxController {
  Stopwatch timerWatch = Stopwatch();
  Stopwatch lastWatch = Stopwatch();

  Timer? timerTimer;
  Timer? lastTimer;

  int startTimerCount = 0;
  int lastTimerCount = 0;

  RxString startTimerString = ''.obs;
  RxString lastTimerString = 'none'.obs;

  RxString selectedImpedanceButton = 'Low'.obs;
  RxString selectedDefiButton = 'Auto'.obs;
  RxString selectedSynchronicityButton = 'Sync'.obs;

  RxBool metronomeOn = false.obs;
  RxString loaded = 'Loaded'.obs;

  RxInt shockPower = 0.obs;
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

  void toggleLoaded(String value) async {
    if (loaded.value == 'Shock') {
      numberOfShocks++;
      shockPower.value = 0;
      loaded.value = value;
    } else {
      loaded.value = 'Loading';
      Timer.periodic(const Duration(milliseconds: 1), (timer) {
        shockPower.value++;
        if (shockPower >= 200) {
          timer.cancel();
          loaded.value = value;
        }
      });
    }
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
