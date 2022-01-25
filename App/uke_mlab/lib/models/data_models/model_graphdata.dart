import 'package:flutter/material.dart';

/// [ChartData] represents a datapoint with [time], [counter], and [value] to be rendered in a graph.
///
/// This uses the mixin [ChartData.asCPR] and [ChartData.asNIBD] to initialize special datapoints for the [CprGraph] and [HistoryGraph].
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

/// This mixin represents [ChartData.asCPR] provided for the scenarios.
///
/// Specifies the [color] to signal the pressure depth of performed CPR compressions with green for the interval between 5 and 6. Otherwise red is specified.
/// This color property is used to color the bars in the [CprGraph].
///
/// ### General information about the CPR depth indicated in red and green.
/// Please consider the recommendations for a optimal CPR to understand why the colors are set the way they are. (https://www.cprblspros.com/cpr-cheat-sheet-2022)
///
mixin cpr {
  Color color = Colors.white;

  ///evaluates the [Color] that has to be set for the Bars in the [CprGraph]. This Method is called when a [ChartData] is instanciated with the Constructor [ChartData.asCPR]
  void evaluateColor({required value}) {
    if (value >= 5 && value <= 6) {
      color = Colors.green;
    } else {
      color = Colors.red;
    }
  }
}

/// This mixin represents [ChartData.asNIBD] provided for the scenarios.
///
/// Specifies the [systolicPressure], [diastolicPressure], and the [meanArterialPressure].
/// [meanArterialPressure] is calculated using [systolicPressure] and [diastolicPressure].
///
/// ### General information about blood pressure.
/// (https://en.wikipedia.org/wiki/Blood_pressure)
mixin NIBD {
  late int systolicPressure;
  late int diastolicPressure;
  late int meanArterialPressure;

  /// Implements the calculation of [meanArterialPressure] using [systolicPressure] and [diastolicPressure].
  void evaluarePressures({required List sysDiaPressures}) {
    systolicPressure = sysDiaPressures[0];
    diastolicPressure = sysDiaPressures[1];

    meanArterialPressure = (diastolicPressure + (1 / 3) * (systolicPressure - diastolicPressure)).toInt();
  }
}
