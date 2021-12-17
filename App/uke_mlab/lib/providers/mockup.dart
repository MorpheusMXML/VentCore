import 'dart:convert';
import 'dart:math';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

// GetX requires Bindings for Controllers
class MonitorBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(MonitorController());
  }
}

/// GetX Controller contains variables used by other widgets
/// Sample Data, update function for graphs and tap detection
class MonitorController extends GetxController {
  var dataList = [].obs;
  var loading = true.obs;

  @override
  void onInit() {
    super.onInit();
    readJson();
  }

  Future readJson() async {
    var jsonString = await rootBundle.loadString('assets/data.json');
    var source = await jsonDecode(jsonString.toString())["data"];
    dataList.value = source;
    loading.value = false;
  }

  // Random number generation
  final Random random = Random();
  // Contains a list with information about each graph that can be displayed
  List<Map<String, Object?>> allGraphs = [
    {
      "type": {
        "abbr": "HF",
        "id": "HeartFrequency",
        "index": 0,
      },
      "data": List.filled(1500, ChartDataMockup(DateTime.now(), 0, 0)).obs,
      "color": Colors.green,
      "count": 0,
      "alarm": "none".obs,
      "visible": true.obs,
      "muted": false.obs,
      "controller": ControllerList().controller1
    },
    {
      "type": {
        "abbr": "SPO2",
        "id": "OxygenSaturation",
        "index": 1,
      },
      "data": List.filled(1500, ChartDataMockup(DateTime.now(), 0, 0)).obs,
      "color": Colors.blue,
      "count": 0,
      "alarm": "none".obs,
      "visible": true.obs,
      "muted": false.obs,
      "controller": ControllerList().controller2
    },
    {
      "type": {
        "abbr": "CO2",
        "id": "Sinus",
        "index": 2,
      },
      "data": List.filled(1500, ChartDataMockup(DateTime.now(), 0, 0)).obs,
      "color": Colors.yellow,
      "count": 0,
      "alarm": "none".obs,
      "visible": true.obs,
      "muted": false.obs,
      "controller": ControllerList().controller3,
    },
    {
      "type": {
        "abbr": "A",
        "id": "A",
        "index": 3,
      },
      "data": List.filled(1500, ChartDataMockup(DateTime.now(), 0, 0)).obs,
      "color": Colors.purple,
      "count": 0,
      "alarm": "none".obs,
      "visible": false.obs,
      "muted": false.obs,
      "controller": ControllerList().controller4,
    },
    {
      "type": {
        "abbr": "NIBD",
        "id": "NIBD",
        "index": 4,
      },
      "data": [
        NIBDdata(DateTime.utc(2021, 12, 9, 11, 00), 120, 80),
        NIBDdata(DateTime.utc(2021, 12, 9, 11, 05), 140, 95),
        NIBDdata(DateTime.utc(2021, 12, 9, 11, 10), 180, 100),
        NIBDdata(DateTime.utc(2021, 12, 9, 11, 15), 185, 75),
        NIBDdata(DateTime.utc(2021, 12, 9, 11, 20), 200, 110),
      ].obs,
      "color": Colors.red,
      "count": 0,
      "alarm": "none".obs,
      "visible": false.obs,
      "muted": false.obs,
      "controller": ControllerList().controller5,
    },
  ].obs;

  // Maps ippvValue Names to their value
  Map<String, RxInt> ippvValues = {
    "Freq.": 20.obs,
    "Vt": 40.obs,
    "PEEP": 60.obs
  };

  // Data used by Value Boxes
  final RxList<ChartDataMockup> nibdValue =
      List.filled(1, ChartDataMockup(DateTime.now(), 0, 0)).obs;
  final RxList<ChartDataMockup> mveValue =
      List.filled(1, ChartDataMockup(DateTime.now(), 0, 0)).obs;
  final RxList<ChartDataMockup> breathFreqValue =
      List.filled(1, ChartDataMockup(DateTime.now(), 0, 0)).obs;

  // State for Graph Adder Button
  RxBool isAddGraphTapped = false.obs;

  // Alarm Message that is displayed in the App Bar
  RxString alarmMessage = "".obs;

  var addedDataIndexes = <int>[for (var i = 1400; i <= 1499; i++) i];
  var removedDataIndexes = <int>[for (var i = 0; i <= 99; i++) i];

  // This method should only be called once(!) in the programm
  // Starts a timer which updates the graphs each 50ms
  void activateTimer() {
    Timer.periodic(
      const Duration(milliseconds: 2000),
      (timer) {
        if (loading.value) {
          print("loading");
        } else {
          for (var graph = 0; graph <= allGraphs.length - 1; graph++) {
            if (allGraphs[graph]["controller"] != null) {
              (allGraphs[graph]["controller"] as ChartSeriesController)
                  .updateDataSource(
                addedDataIndexes: addedDataIndexes,
                removedDataIndexes: removedDataIndexes,
              );
              updateData(graph);
            }
          }
        }
      },
    );
  }

  // Called for each graph
  // Updates displayed data for a given graph
  updateData(int index) {
    var ref = allGraphs[index];
    List<ChartDataMockup> dataRef = ref["data"] as List<ChartDataMockup>;
    int countRef = ref["count"] as int;

    for (var i = 0; i <= 99; i++) {
      dataRef.add(ChartDataMockup(
          DateTime.now(), dataList[index]["data"][countRef + i], countRef + i));
    }

    for (var i = 0; i <= 99; i++) {
      dataRef.removeAt(0);
    }

    allGraphs[index]["count"] = countRef + 100;

    if (index == 0) {
      // test visual alarm
      if (dataList[0]["data"][allGraphs[0]["count"]] > 5) {
        switchToAlarm(0);
      }

      //bit hacky, but hey its mocked
      updateBoxValue();
    }
  }

  updateBoxValue() {
    int randomInt = random.nextInt(100);
    nibdValue[0] = ChartDataMockup(
        DateTime.now(), randomInt.toDouble(), nibdValue[0].counter + 1);
    randomInt = random.nextInt(100);
    mveValue[0] = ChartDataMockup(
        DateTime.now(), randomInt.toDouble(), mveValue[0].counter + 1);
    randomInt = random.nextInt(100);
    breathFreqValue[0] = ChartDataMockup(
        DateTime.now(), randomInt.toDouble(), breathFreqValue[0].counter + 1);
  }

  // Increments the ippv Value [name]
  void incrementIPPV(name) {
    ippvValues[name]!.value = ippvValues[name]!.value + 1;
  }

  // Decrements the ippv Value [name]
  void decrementIPPV(name) {
    ippvValues[name]!.value = ippvValues[name]!.value - 1;
  }

  // Inverts the graph adder's state
  void invertGraphAdder() {
    isAddGraphTapped.value = !isAddGraphTapped.value;
  }

  // Dead code for Graph Notification
  void invertMuted(int index) {
    (allGraphs[index]["muted"] as RxBool).value =
        !(allGraphs[index]["muted"] as RxBool).value;
  }

  void switchToAlarm(int type) {
    if ((allGraphs[type]["alarm"] as RxString).value == "none") {
      (allGraphs[type]["alarm"] as RxString).value = "alarm";
    }
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

// DataClass used by the Graphs
// x: DateTime, y: value (HF, SpO2, ...)
class ChartDataMockup {
  ChartDataMockup(this.time, this.value, this.counter);
  final DateTime time;
  final double value;
  final int counter;
}

// don't know how else to use controllers in initialGraphs
// (can't initialize them there)
class ControllerList {
  ChartSeriesController? controller1;
  ChartSeriesController? controller2;
  ChartSeriesController? controller3;
  ChartSeriesController? controller4;
  ChartSeriesController? controller5;
}
