import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// DataClass used by the Graphs
// x: DateTime, y: value (HF, SpO2, ...)
class ChartDataMockup {
  ChartDataMockup(this.time, this.value, this.counter);
  final DateTime time;
  final int value;
  final int counter;
}

// GetX requires Bindings for Controllers
class MonitorBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(MonitorController());
  }
}

// GetX Controller contains variables used by other widgets
// Sample Data, update function for graphs and tap detection
class MonitorController extends GetxController {
  Random random = Random();

  List<double> factors = [-0.2, -0.1, 0, 0.1, 0.2];

  // every graph has phases for their frequencies
  int phase1 = 0;
  int phase2 = 0;
  int phase3 = 0;

  // x-axis value
  int count1 = 0;
  int count2 = 0;
  int count3 = 0;

  List<Map<String, Object>> initialGraphs = [
    {
      // type is used as a key, probably could use key property of widgets but
      // there were issues passing <Key> to children
      "type": "1",
      "data": List.filled(30, ChartDataMockup(DateTime.now(), 0, 0)).obs,
      "color": Colors.green
    },
    {
      "type": "2",
      "data": List.filled(30, ChartDataMockup(DateTime.now(), 0, 0)).obs,
      "color": Colors.blue
    },
    {
      "type": "3",
      "data": List.filled(30, ChartDataMockup(DateTime.now(), 0, 0)).obs,
      "color": Colors.yellow
    }
  ].obs;

  RxInt ippvFreq = 12.obs;
  RxInt ippvVt = 600.obs;
  RxDouble ippvPEEP = 5.0.obs;

  void increment(name) {
    switch (name) {
      case "Freq.":
        ippvFreq.value += 1;
        break;
      case "Vt":
        ippvVt.value += 1;
        break;
      default:
        ippvPEEP.value += 1;
    }
  }

  // handle button click on GraphAdder widget
  bool isAddGraphTapped = false;
  void invert() {
    isAddGraphTapped = !isAddGraphTapped;
    update();
  }

  Map<String, Object> muted = {"1": false, "2": false, "3": false};

  void invertMuted(String type) {
    muted[type] = !(muted[type] as bool);
    update();
  }

  // Add variation to set phase values to make it appear more natural
  int getVariation({int num = 20}) {
    double randomFactor = factors[random.nextInt(factors.length)];
    double variation = random.nextInt(num) * randomFactor;
    return variation.round();
  }

  // update function called by the timer in Graph class
  updateData(String type) {
    switch (type) {
      case "1":
        int nextValue1;
        phase1 = (phase1 + 1) % 9;
        count1++;
        switch (phase1) {
          case 1:
            nextValue1 = 40 + getVariation();
            break;
          case 2:
            nextValue1 = 10 + getVariation();
            break;
          case 3:
            nextValue1 = 90 + getVariation();
            break;
          case 4:
            nextValue1 = 10 + getVariation();
            break;
          case 5:
            nextValue1 = 20 + getVariation();
            break;
          case 6:
            nextValue1 = 20 + getVariation();
            break;
          case 7:
            nextValue1 = 60 + getVariation();
            break;
          case 8:
            nextValue1 = 20 + getVariation();
            break;
          default:
            nextValue1 = 20 + getVariation();
        }
        (initialGraphs[0]["data"] as List<ChartDataMockup>)
            .add(ChartDataMockup(DateTime.now(), nextValue1, count1));
        (initialGraphs[0]["data"] as List<ChartDataMockup>).removeAt(0);
        break;

      case "2":
        int nextValue2;
        phase2 = (phase2 + 1) % 4;
        count2++;
        switch (phase2) {
          case 1:
            nextValue2 = 95 + getVariation();
            break;
          case 2:
            nextValue2 = 60 + getVariation();
            break;
          case 3:
            nextValue2 = 60 + getVariation();
            break;
          default:
            nextValue2 = 5 + getVariation();
        }
        (initialGraphs[1]["data"] as List<ChartDataMockup>)
            .add(ChartDataMockup(DateTime.now(), nextValue2, count2));
        (initialGraphs[1]["data"] as List<ChartDataMockup>).removeAt(0);
        break;

      case "3":
        int nextValue3;
        phase3 = (phase3 + 1) % 2;
        count3++;
        switch (phase3) {
          case 1:
            nextValue3 = 90 + getVariation();
            break;
          default:
            nextValue3 = 10 + getVariation();
        }
        (initialGraphs[2]["data"] as List<ChartDataMockup>)
            .add(ChartDataMockup(DateTime.now(), nextValue3, count3));
        (initialGraphs[2]["data"] as List<ChartDataMockup>).removeAt(0);
        break;

      default:
        print("Pain");
    }
  }
}
