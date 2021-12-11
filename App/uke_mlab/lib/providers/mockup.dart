import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/providers/mockup_data.dart';
import 'dart:math';

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
  // type is used as a key, probably could use key property of widgets but
  // there were issues passing <Key> to children
  List<Map<String, Object>> initialGraphs = [
    {
      "type": {"abbr": "HF", "id": "HeartFrequency", "index": 0},
      "data": List.filled(30, ChartDataMockup(DateTime.now(), 0, 0)).obs,
      "color": Colors.green,
      "count": 0,
      "alarm": false.obs,
      "visible": true.obs,
      "muted": false.obs,
    },
    {
      "type": {"abbr": "SPO2", "id": "OxygenSaturation", "index": 1},
      "data": List.filled(30, ChartDataMockup(DateTime.now(), 0, 0)).obs,
      "color": Colors.blue,
      "count": 0,
      "alarm": false.obs,
      "visible": true.obs,
      "muted": false.obs,
    },
    {
      "type": {"abbr": "CO2", "id": "Sinus", "index": 2},
      "data": List.filled(30, ChartDataMockup(DateTime.now(), 0, 0)).obs,
      "color": Colors.yellow,
      "count": 0,
      "alarm": false.obs,
      "visible": true.obs,
      "muted": false.obs,
    },
    {
      "type": {"abbr": "A", "id": "A", "index": 3},
      "data": List.filled(30, ChartDataMockup(DateTime.now(), 0, 0)).obs,
      "color": Colors.purple,
      "count": 0,
      "alarm": false.obs,
      "visible": false.obs,
      "muted": false.obs,
    },
    {
      "type": {"abbr": "NIBD", "id": "NIBD", "index": 4},
      "data": [
        NIBDdata(DateTime.utc(2021, 12, 9, 11, 00), 120, 80),
        NIBDdata(DateTime.utc(2021, 12, 9, 11, 05), 140, 95),
        NIBDdata(DateTime.utc(2021, 12, 9, 11, 10), 180, 100),
        NIBDdata(DateTime.utc(2021, 12, 9, 11, 15), 185, 75),
        NIBDdata(DateTime.utc(2021, 12, 9, 11, 20), 200, 110),
      ].obs,
      "color": Colors.red,
      "count": 0,
      "alarm": false.obs,
      "visible": false.obs,
      "muted": false.obs,
    },
  ].obs;

  Map<String, RxInt> ippvValues = {
    "Freq.": 20.obs,
    "Vt": 40.obs,
    "PEEP": 60.obs
  };

  final RxList<ChartDataMockup> nibdValue =
      List.filled(1, ChartDataMockup(DateTime.now(), 0, 0)).obs;
  final RxList<ChartDataMockup> mveValue =
      List.filled(1, ChartDataMockup(DateTime.now(), 0, 0)).obs;
  final RxList<ChartDataMockup> breathFreqValue =
      List.filled(1, ChartDataMockup(DateTime.now(), 0, 0)).obs;
  final Random random = Random();

  void increment(name) {
    ippvValues[name]!.value = ippvValues[name]!.value + 1;
  }

  void decrement(name) {
    ippvValues[name]!.value = ippvValues[name]!.value - 1;
  }

  // handle button click on GraphAdder widget
  RxBool isAddGraphTapped = false.obs;
  void invert() {
    isAddGraphTapped.value = !isAddGraphTapped.value;
  }

  Map<String, Object> muted = {
    "HeartFrequency": false.obs,
    "OxygenSaturation": false.obs,
    "Sinus": false.obs,
    "A": false.obs,
    "NIBD": false.obs
  };

  void invertMuted(String type) {
    (muted[type] as RxBool).value = !(muted[type] as RxBool).value;
  }

  void switchToAlarm(int type) {
    (initialGraphs[type]["alarm"] as RxBool).value = true;
  }

  RxString alarmMessage = "".obs;

  // update function called by the timer in Graph class
  updateData(int index) {
    Map<String, Object> ref = initialGraphs[index];
    List<ChartDataMockup> dataRef = ref["data"] as List<ChartDataMockup>;
    int countRef = ref["count"] as int;

    dataRef.add(ChartDataMockup(
        DateTime.now(), DataProvider.data[index][countRef % 1000], countRef));
    dataRef.removeAt(0);

    initialGraphs[index]["count"] = countRef + 1;

    //bit hacky, but hey its mocked
    if (index == 0) {
      updateBoxValue();
    }
  }

  updateBoxValue() {
    int randomInt = random.nextInt(100);
    nibdValue[0] =
        ChartDataMockup(DateTime.now(), randomInt, nibdValue[0].counter + 1);
    randomInt = random.nextInt(100);
    mveValue[0] =
        ChartDataMockup(DateTime.now(), randomInt, mveValue[0].counter + 1);
    randomInt = random.nextInt(100);
    breathFreqValue[0] = ChartDataMockup(
        DateTime.now(), randomInt, breathFreqValue[0].counter + 1);
  }
}

class NIBDdata {
  final DateTime? timestamp;
  final int systolicPressure;
  final int diastolicPressure;
  late int mad;
  NIBDdata(this.timestamp, this.systolicPressure, this.diastolicPressure) {
    //Formular for Calculating MAD out of systolic and diastolic pressure
    mad = (diastolicPressure + (1 / 3) * (systolicPressure - diastolicPressure))
        .toInt();
  }
}
