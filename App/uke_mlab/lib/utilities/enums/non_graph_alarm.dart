//TODO: COMMENTARY
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
  ekgArtifact,
  ekgNotConnected,
  vf, // ventricular fibrillation
  vt, // ventricular tachicardy
  sraCheckPuls, // "SR à Puls check"
  cprFeedback,
}

//TODO: COMMENTARY
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
    nonGraphAlarmEnum.ekgArtifact: {
      'message': 'EKG artifact',
    },
    nonGraphAlarmEnum.ekgNotConnected: {
      'message': 'EKG artifact',
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

  get message => attributes[this]!['message'] as String;
}
