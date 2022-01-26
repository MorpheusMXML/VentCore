import 'dart:async';
import 'dart:io';
import 'package:get/get.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:uke_mlab/models/data_models/model_absolute.dart';
import 'package:uke_mlab/utilities/enums/sensor.dart';

/// This class provides the sound production and sound triggering functionallity.
/// Alarm sounds can be triggered, stopped and the SpO2 / ECG Sound for the heartfrequency can be started.
///
/// ### Class Variables
/// + [alarmPlayerCache] loads an instance of type [AudioCache] and sets the sounds folder prefix.
/// + [ecgPlayerCache] loads an instance of type [AudioCache] and sets the sounds folder prefix.
/// + [timer] holds an instance of type [Timer] to control for example the ECG sound timing.
/// + [alarmTimer], [getDataTimer], [cancelTimerBeep] also hold an i
/// - [_alarmSoundFiles] & [_ecgSoundFiles] provide a [Map] where the sounds for the corresponding alarm or ECG sound can be specified.
/// + [alarmPlayer], [ecgPlayer] and [defiPlayer] hold a late [AudioPlayer] instance to controll the audio after triggering it.
/// + [alarmVolume] is a constant to reduce redundant code and change volume in one place.
///
/// ### Methods
/// + [play] starts the alarm of given [SoundIdentifier].
/// + [stop] stops all players.
/// + [saturationHfBeep] calculates according to specified BPM when and how often the ECG Sound should be played.
/// + [playDefiLoadSound] stops all currently active [AudioPlayer], then starts the Loading Sound for the Defi.
/// + [playAlarmSound] plays the [alarmPlayer] in a periodic [Duration].
/// + [stopAudioPlayer] stops a specific given [AudioPlayer] that is currently playing a Sound.
/// + [stopAlarmTimer] stops the [alarmTimer] that is currently looping.

/// {@category Providers}
class SoundController {
  ///Loads AudioAlarm Files into Cache and Provides functionality to Play, Stop them. Also provides ECG Sound per Minute and O2 Saturation.
  final AudioCache alarmPlayerCache = AudioCache(prefix: 'assets/sounds/');
  final AudioCache defiPlayerCache = AudioCache(prefix: 'assets/sounds/');
  final AudioCache ecgPlayerCache = AudioCache(prefix: 'assets/sounds/');
  RxBool ecgSoundActive = false.obs;
  Timer? timer;
  Timer? alarmTimer;
  Timer? getDataTimer;
  Timer? cancelTimerBeep;
  final int getDataTimerDuration = 5;
  final double alarmVolume = 0.3;

  AudioPlayer? alarmPlayer;
  AudioPlayer? ecgPlayer;
  AudioPlayer? defiPlayer;

  /// This [Map<SoundIdentifier, String>] specifies the AlarmType in the [Enum] Key and maps it to the [String] of the Sound Files Name in he Assets/sounds
  /// Folder. If you wish to change the Alarm Sound Files that shall pe blayed. Change them accordingly here and place the Sondfile under [./App/uke_mlab/assets/sounds]
  static const Map<SoundIdentifier, String> _alarmSoundFiles = {
    SoundIdentifier.notification: 'SpaceyNotification.wav',
    SoundIdentifier.monitoringMediumAlert: 'ALERTA.wav',
    SoundIdentifier.monitoringHighAlert: 'DINGDINGSINNG.wav',
    SoundIdentifier.ventilationHighAlert: '2A_High123.wav',
    SoundIdentifier.ventilationMediumAlert: '3H_Notification.wav',
    SoundIdentifier.defiLoading: 'defiLoading.wav',
    SoundIdentifier.defiShockReady: 'defiReady.wav',
  };

  /// This [Map<SoundIdentifier, String>] specifies the EcgSaturation Type in the [Enum] Key and maps it to the [String] of the Sound Files Name in he Assets/sounds
  /// Folder. If you wish to change the ECG Sound Files that shall pe blayed. Change them accordingly here and place the Sondfile under [./App/uke_mlab/assets/sounds]
  static const Map<SoundIdentifier, String> _ecgSoundFiles = {
    SoundIdentifier.hFnormal: 'ECG_100_Clean.wav',
    SoundIdentifier.hF80: 'ECG_80_Clean.wav',
    SoundIdentifier.hF75: 'ECG_75_Clean.wav',
    SoundIdentifier.hF65: 'ECG_65_Clean.wav',
    SoundIdentifier.hF50: 'ECG_50wav.wav',
    SoundIdentifier.hfzero: 'hfzero.wav'
  };

  /// Constructor for this. Loads the specified Sound files from [_alarmSoundFiles] & [ecgecgSoundFiles] into the Cache of the Application.
  SoundController() {
    alarmPlayerCache.loadAll(_alarmSoundFiles.values.toList());
    ecgPlayerCache.loadAll(_ecgSoundFiles.values.toList());
    defiPlayerCache.loadAll(_alarmSoundFiles.values.toList());
  }

  /// Plays the SoundAlarm for the AlarmType specified with [soundIdentifier].
  play(Enum soundIdentifier) async {
    alarmPlayer = await alarmPlayerCache
        .play(_alarmSoundFiles[soundIdentifier].toString());
  }

  /// Stops all currently active [AudioPlayer], then starts the Loading Sound for the Defi.
  ///
  /// When this Loading Sound is completed, the Warning for the Charged and armed Defibrillator is looping.
  /// Plays the [defiPlayer] after this [SoundIdentifier.defiLoading] finished it will loop over [SoundIdentifier.defiShockReady].
  playDefiLoadSound() async {
    stop();
    defiPlayer = await defiPlayerCache.play(
        _alarmSoundFiles[SoundIdentifier.defiLoading].toString(),
        volume: alarmVolume);
    defiPlayer!.onPlayerCompletion.listen((event) async {
      defiPlayer = await defiPlayerCache.loop(
          _alarmSoundFiles[SoundIdentifier.defiShockReady].toString(),
          volume: alarmVolume + 0.1);
    });
  }

  /// Plays the [alarmPlayer] in a periodic [Duration] defined by [timerDuration].
  ///
  /// If [timerDuration] = 0 it wont start an [alarmTimer]
  playAlarmSound(SoundIdentifier? alarmSound, int timerDuration) async {
    if (alarmSound != null) {
      stopAudioPlayer(alarmPlayer);
      if (timerDuration != 0) {
        alarmTimer = Timer.periodic(Duration(seconds: timerDuration),
            ((alarmTimer) async {
          alarmPlayer = await alarmPlayerCache.play(
            _alarmSoundFiles[alarmSound].toString(),
            volume: alarmVolume,
            mode: PlayerMode.LOW_LATENCY,
          );
        }));
      } else {
        alarmPlayer = await alarmPlayerCache.play(
          _alarmSoundFiles[alarmSound].toString(),
          volume: alarmVolume,
          mode: PlayerMode.LOW_LATENCY,
        );
      }
    }
  }

  ///Stops all [AudioPlayer]'s that are currently playing a Sound.
  stop() async {
    ecgSoundActive.value = false;
    if (alarmPlayer != null) {
      alarmPlayer!.stop();
      alarmPlayer!.dispose();
      alarmPlayer = null;
    }
    if (defiPlayer != null) {
      defiPlayer!.stop();
      defiPlayer!.dispose();
      defiPlayer = null;
    }
    if (ecgPlayer != null) {
      ecgPlayer!.stop();
      ecgPlayer!.dispose();
      ecgPlayer = null;
    }
    if (alarmTimer != null) {
      alarmTimer!.cancel();
      alarmTimer = null;
    }
    if (timer != null) {
      timer!.cancel();
      timer = null;
    }
    if (getDataTimer != null) {
      getDataTimer!.cancel();
      getDataTimer = null;
    }
  }

  /// Stops a specific [AudioPlayer] that is currently playing a Sound.
  stopAudioPlayer(AudioPlayer? audioPlayer) {
    if (audioPlayer != null) {
      audioPlayer.stop();
    }
  }

  /// Stops the [alarmTimer] that is currently looping the [alarmPlayer].
  stopAlarmTimer() async {
    if (alarmTimer != null) {
      alarmTimer!.cancel();
      alarmTimer = null;
    }
  }

  /// Function starts the ECG Sound in the rhythm specified with [bpm] and playes the accordingly Pitched Sound File to the Oxygen Saturation specified with [spO2]
  /// The Lower the spO2 saturation, the lower Pitched the ECG Sound.
  ///
  /// The Rhythm the ECG Sound playes is calculated by getting the Hz Freq. of the Sound and transfoming it into the Milliseconds they have to be distributed at.
  /// Creates a [Duration] and stores the duration needed till the next Sound hast to be played.
  ///
  /// Creates a [Timer.periodic()] to repeat the play Function of the [ecgPlayerCache]. This triggeres the Sound chosen depending on the [spO2] this method got called with.
  /// Stores the AudioPlayer controller in [ecgPlayer] to keep access on stopping the Sound with [this.stop()].
  ///
  /// ### Rhythm Calculation and Timing
  ///
  /// ```dart
  /// double beepHz = bpm / 60;
  /// int milliesTillNext = ((1 / beepHz) * 1000).toInt();
  ///Duration duration = Duration(milliseconds: milliesTillNext);
  ///```
  saturationHfBeep({required int bpm, required int spO2}) async {
    const double volume = 0.1;
    String ecgSound = _ecgSoundFiles[SoundIdentifier.hFnormal].toString();

    if (spO2 > 90) {
      ecgSound = _ecgSoundFiles[SoundIdentifier.hFnormal].toString();
    } else if (spO2 > 80) {
      ecgSound = _ecgSoundFiles[SoundIdentifier.hF80].toString();
    } else if (spO2 > 70) {
      ecgSound = _ecgSoundFiles[SoundIdentifier.hF75].toString();
    } else if (spO2 > 60) {
      ecgSound = _ecgSoundFiles[SoundIdentifier.hF65].toString();
    } else {
      ecgSound = _ecgSoundFiles[SoundIdentifier.hF50].toString();
    }

    if (timer != null) {
      timer?.cancel();
      timer = null;
    }

    if (bpm != 0) {
      double beepHz = bpm / 60;
      int milliesTillNext = ((1 / beepHz) * 1000).toInt();
      Duration duration = Duration(milliseconds: milliesTillNext);

      timer = Timer.periodic(
        duration,
        ((timer) async {
          if (Platform.isAndroid) {
            ecgPlayer = await ecgPlayerCache.play(
              ecgSound,
              volume: volume,
              mode: PlayerMode.LOW_LATENCY,
            );

            /// since stayAwake is not implemented on macOs, we like to check
          } else if (Platform.isIOS) {
            ecgPlayer = await ecgPlayerCache.play(
              ecgSound,
              volume: volume,
              mode: PlayerMode.LOW_LATENCY,
            );
          }

          /// fix for double timer after hot reload, cancels running timer 1 second after a reload of method should have occoured
          if (cancelTimerBeep != null) {
            cancelBeepTimer(duration);
          }
        }),
      );
    } else {
      if (Platform.isAndroid) {
        ecgPlayer = await ecgPlayerCache.play(
          _ecgSoundFiles[SoundIdentifier.hfzero].toString(),
          volume: volume,
          mode: PlayerMode.LOW_LATENCY,
        );

        /// since stayAwake is not implemented on macOs, we like to check
      } else if (Platform.isIOS) {
        ecgPlayer = await ecgPlayerCache.play(
          _ecgSoundFiles[SoundIdentifier.hfzero].toString(),
          volume: volume,
          mode: PlayerMode.LOW_LATENCY,
        );
      }

      /// fix for double timer after hot reload, cancels running timer 1 second after a reload of method should have occoured
      if (cancelTimerBeep != null) {
        cancelBeepTimer(Duration(seconds: getDataTimerDuration + 1));
      }
    }
  }

  /// internal method, to fix double timers after hot reload
  void cancelBeepTimer(Duration duration) {
    cancelTimerBeep = Timer(duration, () {
      timer?.cancel();
      timer = null;
      cancelTimerBeep?.cancel();
      cancelTimerBeep = null;
    });
  }

  /// Creates the [Timer.periodic()], gets the [DataModelAbsolute] for HF and SPO2 and starts triggers periodically the saturation HF Beep Update Method.
  /// This happens only every 3 seconds to take it easy on the performance.
  void startSaturationHFSound() {
    ecgSoundActive.value = true;
    DataModelAbsolute hfModel =
        Get.find<DataModelAbsolute>(tag: sensorEnumAbsolute.hfAbsolute.name);
    DataModelAbsolute spo2Model =
        Get.find<DataModelAbsolute>(tag: sensorEnumAbsolute.spo2Absolute.name);
    getDataTimer ??=
        Timer.periodic(Duration(seconds: getDataTimerDuration), (timer) {
      saturationHfBeep(
          bpm: hfModel.absoluteValue.value.toInt(),
          spO2: spo2Model.absoluteValue.value.toInt());
    });
  }
}

///This [SoundIdentifier] specifies the categories of alarms and ECG sound types there are. Used to identify the soundfile and triggering of it in the [SoundController] class this is needed for.
///this needs to be changed to add more categories of alarms.
///
///#### Current Categories:
///+   notifiation,
///+   mediumAlert,
///+   highAlert,
///+   hFnormal,
///+   hF80,
///+   hF75,
///+   hF65,
///+   hF50,
enum SoundIdentifier {
  notification,
  monitoringMediumAlert,
  monitoringHighAlert,
  ventilationMediumAlert,
  ventilationHighAlert,
  defiLoading,
  defiShockReady,
  hFnormal,
  hF80,
  hF75,
  hF65,
  hF50,
  hfzero,
}
