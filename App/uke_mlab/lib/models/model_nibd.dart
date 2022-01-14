class NIBDdata {
  final DateTime time;
  final int systolicPressure;
  final int diastolicPressure;
  late int mad;

  NIBDdata(this.time, this.systolicPressure, this.diastolicPressure) {
    //Formular for Calculating MAD out of systolic and diastolic pressure
    mad = (diastolicPressure + (1 / 3) * (systolicPressure - diastolicPressure)).toInt();
  }
}
