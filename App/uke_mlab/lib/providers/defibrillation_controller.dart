import 'dart:async';

import 'package:get/get.dart';

/// This class implements the controller for the defibrillator.
/// This controller manages the state of the defibrillator, tracks the timings, number of shocks and shock power.
///
/// It further implements helper methods that are calles to change the settings of the defibrillator like, synchronicity, shockPower and impedance.
/// Note that most of the class variables use [GetX] and the corresponding data classes [RxString], [RxBool], [RxInt] to make the changes of these variables observable for the widgets that display these values.
///
/// {@category Providers}
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
  RxBool toggleButtonAvailable = true.obs;

  RxInt shockPower = 200.obs;
  RxBool shockClicked = false.obs;

  RxString systemDiagnosis = ''.obs;

  RxInt numberOfShocks = 0.obs;

  /// This Method starts the Timer when the Defibrillator is Started for the first Time.
  void startTimerWatch() {
    timerTimer?.cancel();
    timerWatch.start();
    timerTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      startTimerCount++;
      startTimerString.value = timerToString(startTimerCount);
    });
  }

  /// This Method sets the Timer for the Time since the last Shock was applied.
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

  /// This Method convertes the Timer to an String in the correct Formatting for Displaying.
  String timerToString(int seconds) {
    Duration duration = Duration(seconds: seconds);

    String twoDigits(int n) => '$n'.padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return '$twoDigitMinutes:$twoDigitSeconds';
  }

  /// THis implements the Changing Behaviour of the Metronome Toggle Button
  void toggleMetronome(bool changed) {
    metronomeOn.value = changed;
  }

  /// This Method sets the State of the Impedance that was selected by the User.
  void setSelectedImpedanceButton(String name) {
    selectedImpedanceButton.value = name;
  }

  /// This Method sets the Default Settings when the Mode 'Auto' is selected to Impedence 'OK' and Synchrinicity to 'Sync'
  void setSelectedDefiButton(String name) {
    if (name == 'Auto') {
      toggleMetronome(true);
      setSelectedImpedanceButton('OK');
      setSelectedSynchronicityButton('Sync');
    }
    selectedDefiButton.value = name;
  }

  /// This Method sets the State of the selected Synchronicity of the Defibrillator.
  void setSelectedSynchronicityButton(String name) {
    selectedSynchronicityButton.value = name;
  }
}
