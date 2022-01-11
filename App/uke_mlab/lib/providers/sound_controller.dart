import 'package:audioplayers/audioplayers.dart';

class SoundController {
  static AudioCache alarmPlayer = AudioCache(prefix: 'assets/sounds/');
  static AudioCache ecgPlayer = AudioCache(prefix: 'assets/sounds/');

  static const Map<String, String> alarmSoundFiles = {
    'Notification': 'SpaceyNotification.wav',
    'MediumAlert': 'ALERTA.wav',
    'HighAlert': 'DINGDINGSINNG.wav',
  };

  static const Map<String, String> ecgSoundFiles = {
    'HFnormal': 'ECG_100_Clean.wav',
    'HF80': 'ECG_80_Clean.wav',
    'HF75': 'ECG_75_Clean.wav',
    'HF65': 'ECG_65_Clean.wav',
    'HF50': 'ECG_50wav.wav',
  };

  late AudioPlayer alarmPlayerRet;
  late AudioPlayer ecgPlayerRet;
  late String ecgUri;
  late List<int> durations;

  SoundController() {
    alarmPlayer.loadAll(alarmSoundFiles.values.toList());
    //ecgPlayer.loadAll(ecgSoundFiles.values.toList());
    ecgUri = ecgPlayer.load(ecgSoundFiles['HFnormal'].toString()).toString();
  }

  Future<int> getPlaybackDuraion(String uris) async {
    return await ecgPlayerRet.setUrl(uris, isLocal: true).then((value) => ecgPlayerRet.getDuration());
  }

  play(Enum soundIdentifier) async {
    alarmPlayerRet = await alarmPlayer.play(alarmSoundFiles[soundIdentifier.toString()].toString());
  }

  stop() async {
    alarmPlayerRet.stop();
  }

  saturationEcgBpm(int bpm, int spO2) {
    String ecgSound = SoundIdentifier.hFnormal.toString();
    if (spO2 > 90) {
      ecgSound = ecgSoundFiles[SoundIdentifier.hFnormal.toString()].toString();
    } else if (spO2 > 80) {
      ecgSound = ecgSoundFiles[SoundIdentifier.hF80.toString()].toString();
    } else if (spO2 > 70) {
      ecgSound = ecgSoundFiles[SoundIdentifier.hF75.toString()].toString();
    } else if (spO2 > 60) {
      ecgSound = ecgSoundFiles[SoundIdentifier.hF65.toString()].toString();
    } else {
      ecgSound = ecgSoundFiles[SoundIdentifier.hF50.toString()].toString();
    }

    print(getPlaybackDuraion(ecgUri));
  }
}

enum SoundIdentifier { notifiation, mediumAlert, highAlert, hFnormal, hF80, hF75, hF65, hF50 }
