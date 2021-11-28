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
// Sample Data, update function for graphs and tap detection
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

  var data2 = [
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

  var data3 = [
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

  bool isAddGraphTapped = false;
  void invert() {
    isAddGraphTapped = !isAddGraphTapped;
    update();
  }

  updateData() {
    data.add(ChartData(DateTime.now(), random.nextInt(100).toDouble()));
    data.removeAt(0);

    data2.add(ChartData(DateTime.now(), random.nextInt(100).toDouble()));
    data2.removeAt(0);

    data3.add(ChartData(DateTime.now(), random.nextInt(100).toDouble()));
    data3.removeAt(0);
  }
}
