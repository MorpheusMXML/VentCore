import 'package:flutter/material.dart';

class ChartData with cpr, NIBD {
  final DateTime time;
  final int counter;

  final dynamic value;

  ChartData({required this.time, required this.counter, required this.value});

  ChartData.asCPR({required this.time, required this.counter, required this.value}) {
    evaluateColor(value: value);
  }

  ChartData.asNIBD({required this.time, required this.counter, required this.value}) {
    evaluarePressures(sysDiaPressures: value);
  }
}

///This mixin represents CPR Data provided for the Scenatios.
///
///Specifies the [Color] to signal the Pressure depth of performed CPR Compressions with green for the interval between 5 and 6. Otherwise red is Specified.
///This color Property is used to Color the Bars in the [CprGraph].
///
/// ### General Information about the CPR Depth indicated in red and green.
/// Please Consider the recommendations for a optimal CPR to understand why the Colors are set the way they are. (https://www.cprblspros.com/cpr-cheat-sheet-2022)
///
mixin cpr {
  Color color = Colors.white;

  void evaluateColor({required value}) {
    ///evaluates the [Color] that has to be set for the Bars in the [CprGraph]. This Method is called when a [ChartData] is instanciated with the Constructor [ChartData.asCPR]
    if (value >= 5 && value <= 6) {
      color = Colors.green;
    } else {
      color = Colors.red;
    }
  }
}

/* 

class CPRData {
  ///DataClass for CPR Graph in AED Screen.
  final int yvalue;
  final int xvalue;
  late Color color;

  
  CPRData({required this.yvalue, required this.xvalue}) {
    ///Named Parameter [yvalue] and [xvalue] to initialize the corresponding DataPoints for the Graph.
    if (yvalue >= 5 && yvalue <= 6) {
      color = Colors.green;
    } else {
      color = Colors.red;
    }
  }
} */

mixin NIBD {
  int? systolicPressure;
  int? diastolicPressure;
  int? meanArterialPressure;

  evaluarePressures({required List sysDiaPressures}) {
    systolicPressure = sysDiaPressures[0];
    diastolicPressure = sysDiaPressures[1];

    //Formular for Calculating MAD out of systolic and diastolic pressure
    meanArterialPressure = (diastolicPressure! + (1 / 3) * (systolicPressure! - diastolicPressure!)).toInt();
  }
}
