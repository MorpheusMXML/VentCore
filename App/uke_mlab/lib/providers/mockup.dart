<<<<<<< HEAD
<<<<<<< HEAD
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

  List<ChartData> data = [
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

  List<ChartData> data2 = [
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

  List<ChartData> data3 = [
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
=======
//This directory is supposed to hold all the interactions that transact the data from outside the app.
>>>>>>> 3afe214 ([FEATURE]#23 new filestructure)
=======
//This directory is supposed to hold all the interactions that transact the data from outside the app.
>>>>>>> 4924591b61d571eee4862fb71aed813a92e32eed
