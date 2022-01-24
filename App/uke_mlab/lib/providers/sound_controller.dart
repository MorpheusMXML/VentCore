import 'dart:async';
import 'dart:io';
import 'package:get/get.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:uke_mlab/models/data_models/model_absolute.dart';
import 'package:uke_mlab/models/system_state.dart';
import 'package:uke_mlab/utilities/enums/alarm_status.dart';
import 'package:uke_mlab/utilities/enums/non_graph_alarm.dart';
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
  final AudioCache defiPlayerCache = AudioCache(prefix: 'assets/sounds/');
  final AudioCache ecgPlayerCache = AudioCache(prefix: 'assets/sounds/');
  final List<SoundListEntry> soundList = <SoundListEntry>[];
  String? _previousAlarmSound;
  final List<bool> _alarmTypes = [false, false];
  Timer? timer;
  Timer? alarmTimer;
  Timer? getDataTimer;
  Timer? cancelTimerBeep;
  final int getDataTimerDuration = 5;
  final SystemState systemState = Get.find<SystemState>();

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

  ///Constructor for this. Loads the specified Sound files from [alarmSoundFiles] & [ecgecgSoundFiles] into the Cache of the Application.
  SoundController() {
    alarmPlayerCache.loadAll(_alarmSoundFiles.values.toList());
    ecgPlayerCache.loadAll(_ecgSoundFiles.values.toList());
    defiPlayerCache.loadAll(_alarmSoundFiles.values.toList());
  }

  ///Plays the SoundAlarm fot the AlarmType specified with [Enum soundIdentifier].
  play(Enum soundIdentifier) async {
    alarmPlayer = await alarmPlayerCache
        .play(_alarmSoundFiles[soundIdentifier].toString());
  }

  playDefiLoadSound() async {
    stop();
    defiPlayer = await defiPlayerCache.play(
        _alarmSoundFiles[SoundIdentifier.defiLoading].toString(),
        volume: 0.5);
    defiPlayer!.onPlayerCompletion.listen((event) async {
      defiPlayer = await defiPlayerCache.loop(
          _alarmSoundFiles[SoundIdentifier.defiShockReady].toString(),
          volume: 0.6);
    });
  }

  ///Stops all [AudioPlayer]'s that are currently playing a Sound.
  stop() async {
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

  ///Stops a specific [AudioPlayer] that is currently playing a Sound.
  stopAlarmPlayer(AudioPlayer audioPlayer) {
    audioPlayer.stop();
  }

  triggerSoundState(dynamic sensor, int priority) {
    //print(" \nSoundStateTriggered with $sensor");

    // TODO compare list with current system state (eg: is temperature still confirmed?)
    // first try to do so
    soundList.removeWhere((element) {
      // checks whether element is in systemState.absAlarmFieldModel.activeList or systemState.graphList.activeGraphAbsolutes,
      // if it is in neither => remove from soundList
      if (element.type is sensorEnumAbsolute) {
        return !systemState.absAlarmFieldModel.activeList
                .contains(element.type as sensorEnumAbsolute) &&
            !systemState.graphList.activeGraphAbsolutes
                .contains(element.type as sensorEnumAbsolute);
        // could be nicer
        // checks whether element is in generalAlarms, if so returns false => not removed from soundList
      } else if (element.type is nonGraphAlarmEnum) {
        for (var item in systemState.generalAlarms.alarmList) {
          if (item.alarm == element.type as nonGraphAlarmEnum) {
            return false;
          }
        }
        return true;
      } else {
        throw Exception(
            "soundList does contain an element which has neither sensorEnumAbsolute nor nonGraphAlarmEnum as type");
      }
    });

    soundList.removeWhere((item) => item.type == sensor);
    soundList.add(SoundListEntry(type: sensor, priority: priority));

    soundList.sort((a, b) => b.priority.compareTo(a.priority));
    soundList.removeWhere((item) => item.priority < soundList[0].priority);
    //Don't play a sound when prio of new alarm is below prio of max alarm (we should be still looping over that)
    if (soundList[0].priority > priority) {
      return;
    }

    ///For each Entry check Sensor alarmtype if Vent or Monitor.
    for (var entry in soundList) {
      if (entry.type is sensorEnumAbsolute) {
        switch ((entry.type as sensorEnumAbsolute).alarmType) {
          case 1: // is monitor alarm
            _alarmTypes[0] = true;
            break;
          case 2: // is ventilator alarm
            _alarmTypes[1] = true;
            break;
          default:
            throw Exception("sensorEnumAbsolute has wrong defined alarmType");
        }
      }
      // TODO: analyze general alarms too
    }
    print(
        "playAlarm called by ${soundList[0].type.toString()} with prio $priority\n ");
    playAlarm(soundList[0].priority);
  }

  ///Plays right [alarmsound] with right [priority].
  playAlarm(int priority) {
    const double alarmVolume = 0.3;
    int alarmSeconds = 0;
    String alarmSound = "noalarm";
    if (_alarmTypes[0] && _alarmTypes[1]) {
      //Play Monitor+Vent Sounds.
      if (priority == alarmStatus.high.priority) {
        alarmSound =
            _alarmSoundFiles[SoundIdentifier.monitoringHighAlert].toString();
        alarmSeconds = 2;
      } else if (priority == alarmStatus.middle.priority) {
        alarmSound =
            _alarmSoundFiles[SoundIdentifier.monitoringMediumAlert].toString();
        alarmSeconds = 5;
      }
    } else if (_alarmTypes[1]) {
      //Play Vent Alarm.
      if (priority == alarmStatus.high.priority) {
        alarmSound =
            _alarmSoundFiles[SoundIdentifier.ventilationHighAlert].toString();
        alarmSeconds = 2;
      } else if (priority == alarmStatus.middle.priority) {
        alarmSound =
            _alarmSoundFiles[SoundIdentifier.ventilationMediumAlert].toString();
        alarmSeconds = 5;
      }
    } else {
      //Play Monitor Alarm.
      if (priority == alarmStatus.high.priority) {
        alarmSound =
            _alarmSoundFiles[SoundIdentifier.monitoringHighAlert].toString();
        alarmSeconds = 2;
      } else if (priority == alarmStatus.middle.priority) {
        alarmSound =
            _alarmSoundFiles[SoundIdentifier.monitoringMediumAlert].toString();
        alarmSeconds = 5;
      }
    }

    //Don't reset Timer, if same [alarmSound] should be triggered as [_previousAlamSound].
    if (alarmSound == _previousAlarmSound) {
      _alarmTypes[0] = false;
      _alarmTypes[1] = false;
      return;
    }
    //Stop the [alarmTimer], if [priority] is [alarmStatus.none] or no [alarmSound] is choosen.
    else if (alarmSound == "noalarm" ||
        priority <= alarmStatus.confirmed.priority) {
      if (alarmPlayer != null) {
        alarmPlayer!.stop();
        alarmPlayer!.dispose();
        alarmPlayer = null;
      }
      if (alarmTimer != null) {
        alarmTimer?.cancel();
        alarmTimer = null;
      }
      _alarmTypes[0] = false;
      _alarmTypes[1] = false;
      _previousAlarmSound = null;
      return;
    }
    //Register new [alarmTimer] with [alarmSound], [alarmDuration] and [alarmVolume].
    else {
      if (alarmSeconds != 0) {
        if (alarmPlayer != null) {
          alarmPlayer!.stop();
          alarmPlayer!.dispose();
          alarmPlayer = null;
        }
        if (alarmTimer != null) {
          alarmTimer?.cancel();
          alarmTimer = null;
        }

        ///Known Problem: We have to play the sound on first second and after this we use the Timer because the Timer plays on end of duration
        ///This causes and Problem with Toggle to VentilationScreen!
        alarmPlayerCache.play(alarmSound);
        alarmTimer = Timer.periodic(Duration(seconds: alarmSeconds),
            ((alarmTimer) async {
          if (Platform.isAndroid) {
            alarmPlayer = await alarmPlayerCache.play(
              alarmSound,
              volume: alarmVolume,
              mode: PlayerMode.LOW_LATENCY,
            );
            // since stayAwake is not implemented on macOs, we like to check
          } else if (Platform.isIOS) {
            alarmPlayer = await alarmPlayerCache.play(
              alarmSound,
              volume: alarmVolume,
              mode: PlayerMode.LOW_LATENCY,
            );
          }
        }));
      }
    }

    _alarmTypes[0] = false;
    _alarmTypes[1] = false;
    _previousAlarmSound = alarmSound;
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
        Duration(microseconds: 50),
        ((timer) async {
          if (Platform.isAndroid) {
            ecgPlayer = await ecgPlayerCache.play(
              _ecgSoundFiles[SoundIdentifier.hfzero].toString(),
              volume: volume,
              mode: PlayerMode.LOW_LATENCY,
            );
            // since stayAwake is not implemented on macOs, we like to check
          } else if (Platform.isIOS) {
            ecgPlayer = await ecgPlayerCache.play(
              _ecgSoundFiles[SoundIdentifier.hfzero].toString(),
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
    // TODO: end comment
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

class SoundListEntry {
  final dynamic type;

  /// priority of the alarm, should be between 0 and 100
  final int priority;

  SoundListEntry({
    required this.type,
    required this.priority,
  });
}
