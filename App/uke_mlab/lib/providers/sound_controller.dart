import 'dart:async';
import 'dart:io';
import 'package:get/get.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:uke_mlab/models/data_models/model_absolute.dart';
import 'package:uke_mlab/utilities/enums/sensor.dart';

/// This Class provides the SoundPlaying and Triggering Functionallity.
/// Alarms can be Triggered, stopped and the SpO2 / ECG Sound for the Heartfrequency can be started.
///
/// ### Class Variables
/// - [alarmPlayerCache] loads a Instance of Type [AudioCache] and sets the sounds Folder prefix.
/// + [ecgPlayerCache] loads a Instance of Type [AudioCache] and sets the sounds Folder prefix.
/// + [timer] holds a Inscante of Type [Timer] to control the ECG Sunds Timing
/// + [_alarmSoundFiles] & [_ecgSoundFiles] provide a Map where the Sounds for the corresponding Alarm or ECG Sound can be specified.
/// + [alarmPlayer] & [ecgPlayer] hold a late [AudioPlayer] Instance to controll the Audio after Triggering it.
///
/// ### Methods
/// + [play(Enum SoundIdentifier)] starts the alarm SoundIdentifier.
/// + [stop()] stops all players.
/// + [saturationHfBeep(int BPM, int spO2)] calculates according to specified BPM when and how often the ECG Sound should be played.
///
class SoundController {
  ///Loads AudioAlarm Files into Cache and Provides functionality to Play, Stop them. Also provides ECG Sound per Minute and O2 Saturation.
  final AudioCache alarmPlayerCache = AudioCache(prefix: 'assets/sounds/');
  final AudioCache ecgPlayerCache = AudioCache(prefix: 'assets/sounds/');
  Timer? timer;
  Timer? getDataTimer;
  Timer? cancelTimerBeep;
  final int getDataTimerDuration = 5;

  AudioPlayer? alarmPlayer;
  AudioPlayer? ecgPlayer;

  /// This [Map<SoundIdentifier, String>] specifies the AlarmType in the [Enum] Key and maps it to the [String] of the Sound Files Name in he Assets/sounds
  /// Folder. If you wish to change the Alarm Sound Files that shall pe blayed. Change them accordingly here and place the Sondfile under [./App/uke_mlab/assets/sounds]
  static const Map<SoundIdentifier, String> _alarmSoundFiles = {
    SoundIdentifier.notifiation: 'SpaceyNotification.wav',
    SoundIdentifier.monitoringMediumAlert: 'ALERTA.wav',
    SoundIdentifier.monitoringHighAlert: 'DINGDINGSINNG.wav',
    SoundIdentifier.ventilationHighAlert: '3H_HighAlert.wav',
    SoundIdentifier.ventilationMediumAlert: '3H_Notification.wav',
    SoundIdentifier.defiLoading: 'defiLoading.wav',
    SoundIdentifier.defiShockReady: 'defiReady.wav'
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

  ///Constructor for this. Loads the specified Sound files from [alarmSoundFiles] & [ecgecgSoundFiles] into the Cache of the Application.
  SoundController() {
    alarmPlayerCache.loadAll(_alarmSoundFiles.values.toList());
    ecgPlayerCache.loadAll(_ecgSoundFiles.values.toList());
  }

  ///playes the SoundAlarm fot the AlarmType specified with [Enum soundIdentifier].
  play(Enum soundIdentifier) async {
    alarmPlayer = await alarmPlayerCache
        .play(_alarmSoundFiles[soundIdentifier].toString());
  }

  playDefiLoadSound() async {
    stop();
    alarmPlayer = await alarmPlayerCache.play(
        _alarmSoundFiles[SoundIdentifier.defiLoading].toString(),
        volume: 0.5,
        mode: PlayerMode.LOW_LATENCY);
    alarmPlayer!.onPlayerCompletion.listen((event) async {
      print("ABC");
      alarmPlayer = await alarmPlayerCache
          .loop(_alarmSoundFiles[SoundIdentifier.defiShockReady].toString());
    });
  }

  /// stops all [AudioPlayer]'s that are currently playing a Sound.
  stop() async {
    if (alarmPlayer != null) {
      alarmPlayer!.stop();
      alarmPlayer!.dispose();
      alarmPlayer = null;
    }
    if (ecgPlayer != null) {
      ecgPlayer!.stop();
      ecgPlayer!.dispose();
      ecgPlayer = null;
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
    const double volume = 0.3;
    String ecgSound = _ecgSoundFiles[SoundIdentifier.hFnormal].toString();
    //ecgPlayerRet = await ecgPlayer.play(ecgSound, volume: 0);

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

      /*     if (ecgPlayerRet.state == PlayerState.PLAYING) {
        print('stopping Player');
        ecgPlayerRet.stop();
      } */

      timer = Timer.periodic(
        duration,
        ((timer) async {
          if (Platform.isAndroid) {
            ecgPlayer = await ecgPlayerCache.play(
              ecgSound,
              volume: volume,
              mode: PlayerMode.LOW_LATENCY,
            );
            // since stayAwake is not implemented on macOs, we like to check
          } else if (Platform.isIOS) {
            ecgPlayer = await ecgPlayerCache.play(
              ecgSound,
              volume: volume,
              mode: PlayerMode.LOW_LATENCY,
            );
          }

          // fix for double timer after hot reload, cancels running timer 1 second after a reload of method should have occoured
          if (cancelTimerBeep != null) {
            cancelBeepTimer(duration);
          }
        }),
      );
    } else {
      timer = Timer.periodic(
        Duration(seconds: getDataTimerDuration),
        ((timer) async {
          if (Platform.isAndroid) {
            ecgPlayer = await ecgPlayerCache.play(
              ecgSound,
              volume: volume,
              mode: PlayerMode.LOW_LATENCY,
            );
            // since stayAwake is not implemented on macOs, we like to check
          } else if (Platform.isIOS) {
            ecgPlayer = await ecgPlayerCache.play(
              ecgSound,
              volume: volume,
              mode: PlayerMode.LOW_LATENCY,
            );
          }

          // fix for double timer after hot reload, cancels running timer 1 second after a reload of method should have occoured
          if (cancelTimerBeep != null) {
            cancelBeepTimer(Duration(seconds: getDataTimerDuration + 1));
          }
        }),
      );
    }
  }

  // internal method, to fix double timers after hot reload
  void cancelBeepTimer(Duration duration) {
    cancelTimerBeep = Timer(duration, () {
      timer?.cancel();
      timer = null;
      cancelTimerBeep?.cancel();
      cancelTimerBeep = null;
    });
  }

  void startSaturationHFSound() {
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

///This [enum] Specifies the Categories of Alarms and ECG Sound Types there are. Used to identify the SoundFile and triggering of it in the [SoundController] Class this is needed for.
///this needs to be Changed to add more Categories of Alarms.
///
///#### Current Categories:
///+ notifiation,
///+   mediumAlert,
///+   highAlert,
///+   hFnormal,
///+   hF80,
///+   hF75,
///+   hF65,
///+   hF50,
enum SoundIdentifier {
  notifiation,
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
