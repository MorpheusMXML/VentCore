import 'dart:math';

import 'package:get/get.dart';

class ChartData {
  ChartData(this.time, this.value);
  final DateTime time;
  final double value;
}

class MonitorBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(MonitorController());
  }
}

class MonitorController extends GetxController {
  int counter = 5;

  var data = [
    ChartData(DateTime.now(), 0),
    ChartData(DateTime.now(), 0),
    ChartData(DateTime.now(), 0),
    ChartData(DateTime.now(), 0),
    ChartData(DateTime.now(), 0),
    ChartData(DateTime.now(), 0),
    ChartData(DateTime.now(), 0),
    ChartData(DateTime.now(), 0),
    ChartData(DateTime.now(), 0),
    ChartData(DateTime.now(), 0),
    ChartData(DateTime.now(), 0),
    ChartData(DateTime.now(), 0),
    ChartData(DateTime.now(), 0),
    ChartData(DateTime.now(), 0),
    ChartData(DateTime.now(), 0),
    ChartData(DateTime.now(), 0)
  ].obs;

  var data2 = [ChartData(DateTime.now(), 0)].obs;

  var data3 = [ChartData(DateTime.now(), 0)].obs;

  Random random = Random();

  updateData() {
    data.add(ChartData(DateTime.now(), random.nextInt(100).toDouble()));
    data.removeAt(0);
  }
}
