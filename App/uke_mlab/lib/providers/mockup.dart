import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/providers/mockup_data.dart';

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
      "type": {"id": "HeartFrequency", "index": 0},
      "data": List.filled(30, ChartDataMockup(DateTime.now(), 0, 0)).obs,
      "color": Colors.green,
      "count": 0,
      "alarm": false.obs
    },
    {
      "type": {"id": "OxygenSaturation", "index": 1},
      "data": List.filled(30, ChartDataMockup(DateTime.now(), 0, 0)).obs,
      "color": Colors.blue,
      "count": 0,
      "alarm": false.obs
    },
    {
      "type": {"id": "Sinus", "index": 2},
      "data": List.filled(30, ChartDataMockup(DateTime.now(), 0, 0)).obs,
      "color": Colors.yellow,
      "count": 0,
      "alarm": false.obs
    }
  ].obs;

  List<ChartDataMockup> initialNIBD =
      List.filled(30, ChartDataMockup(DateTime.now(), 0, 0)).obs;

  Map<String, RxInt> ippvValues = {
    "Freq.": 20.obs,
    "Vt": 40.obs,
    "PEEP": 60.obs
  };

  void increment(name) {
    ippvValues[name]!.value = ippvValues[name]!.value + 1;
  }

  void decrement(name) {
    ippvValues[name]!.value = ippvValues[name]!.value - 1;
  }

  // handle button click on GraphAdder widget
  bool isAddGraphTapped = false;
  void invert() {
    isAddGraphTapped = !isAddGraphTapped;
    update();
  }

  Map<String, Object> muted = {
    "HeartFrequency": false,
    "OxygenSaturation": false,
    "Sinus": false,
  };

  void invertMuted(String type) {
    muted[type] = !(muted[type] as bool);
    update();
  }

  bool isInAlarmState = false;
  void switchToAlarm(int type) {
    (initialGraphs[type]["alarm"] as RxBool).value = true;
  }

  // update function called by the timer in Graph class
  updateData(int index) {
    print(index);

    Map<String, Object> ref = initialGraphs[index];
    List<ChartDataMockup> dataRef = ref["data"] as List<ChartDataMockup>;
    int countRef = ref["count"] as int;

    dataRef.add(ChartDataMockup(
        DateTime.now(), DataProvider.data[index][countRef % 1000], countRef));
    dataRef.removeAt(0);

    initialGraphs[index]["count"] = countRef + 1;
  }
}

class NIBDdata {
  final DateTime? timestamp;
  final int systolicPressure;
  final int diastolicPressure;
  late int mad;
  NIBDdata(this.timestamp, this.systolicPressure, this.diastolicPressure) {
    //Formular for Calculating MAD out of systolic and diastolic pressure
    mad = (diastolicPressure + (1 / 3) * (systolicPressure - diastolicPressure)).toInt();
  }
}
