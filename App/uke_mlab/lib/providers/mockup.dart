import 'dart:math';
import 'package:get/get.dart';

// DataClass used by the Graphs
// x: DateTime, y: value (HF, SpO2, ...)
class ChartData {
  ChartData(this.time, this.value);
  final DateTime time;
  final double value;
}

// GetX requires Bindings for Controllers
class MonitorBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(MonitorController());
  }
}

// GetX Controller contains variables used by other widgets
// Sample Data and update function for graphs
class MonitorController extends GetxController {
  Random random = Random();

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

  updateData() {
    data.add(ChartData(DateTime.now(), random.nextInt(100).toDouble()));
    data.removeAt(0);
  }
}
