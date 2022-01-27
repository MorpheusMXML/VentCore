import 'package:uke_mlab/models/data_models/model_absolute.dart';

/// Enum containing keys for alarms not directly related to a [DataModelAbsolute] which are mocked using this enum.
///
/// These are mostly alarms comming directly from the medical device, except for [vt] and [vf]
///
/// {@category Enums}
enum nonGraphAlarmEnum {
  spo2bad,
  spo2weak,
  spo2disconnected,
  spo2NoMeasure, // spo2 not measurable
  leckageHigh,
  ventDisconnect,
  o2low, //pressure low
  o2empty,
  nibpUnavail, //nibp not measurable
  lostConnection,
  ecgArtifact,
  ecgNotConnected,
  vf, // ventricular fibrillation
  vt, // ventricular tachicardy
  sraCheckPuls, // "SR à Puls check"
  cprFeedback,
}

/// Contains a Map [attributes] with [nonGraphAlarmEnum] as key to another key-value pair containing information regarding the Alarm.
///
/// Currently the only entry on the second level Map has 'message' as key.
extension NonGraphAlarmAttributes on nonGraphAlarmEnum {
  static const Map<nonGraphAlarmEnum, Map<String, dynamic>> attributes = {
    nonGraphAlarmEnum.spo2bad: {
      'message': 'SpO2 signal bad',
    },
    nonGraphAlarmEnum.spo2weak: {
      'message': 'SpO2 signal weak',
    },
    nonGraphAlarmEnum.spo2disconnected: {
      'message': 'SpO2 signal disconnection',
    },
    nonGraphAlarmEnum.spo2NoMeasure: {
      'message': 'SpO2 not measurable',
    },
    nonGraphAlarmEnum.leckageHigh: {
      'message': 'High Leckage detected',
    },
    nonGraphAlarmEnum.ventDisconnect: {
      'message': 'Ventilator disconnected',
    },
    nonGraphAlarmEnum.o2low: {
      'message': 'O2 cylinder at low level',
    },
    nonGraphAlarmEnum.o2empty: {
      'message': 'O2 cylinder empty',
    },
    nonGraphAlarmEnum.nibpUnavail: {
      'message': 'NIBP not measurable',
    },
    nonGraphAlarmEnum.lostConnection: {
      'message': 'Connection lost',
    },
    nonGraphAlarmEnum.ecgArtifact: {
      'message': 'ECG artifact',
    },
    nonGraphAlarmEnum.ecgNotConnected: {
      'message': 'ECG artifact',
    },
    nonGraphAlarmEnum.vf: {
      'message': 'Ventricular fibrillation',
    },
    nonGraphAlarmEnum.vt: {
      'message': 'Ventricular tachicardy',
    },
    nonGraphAlarmEnum.sraCheckPuls: {
      'message': 'SR à Puls check',
    },
    nonGraphAlarmEnum.cprFeedback: {
      'message': 'CPR feedback',
    },
  };

  /// Returns 'message' value from the [attributes] map
  get message => attributes[this]!['message'] as String;
}
