import 'dart:math';
import 'package:get/get.dart';

// DataClass used by the Graphs
// x: DateTime, y: value (HF, SpO2, ...)
class ChartData {
  ChartData(this.time, this.value, this.counter);
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

  int phase = 0;

  int count = 0;

  List<ChartData> data = List.filled(30, ChartData(DateTime.now(), 0, 0)).obs;
  List<ChartData> data2 = List.filled(30, ChartData(DateTime.now(), 0, 0)).obs;
  List<ChartData> data3 = List.filled(30, ChartData(DateTime.now(), 0, 0)).obs;

  bool isAddGraphTapped = false;
  void invert() {
    isAddGraphTapped = !isAddGraphTapped;
    update();
  }

  updateData(String type) {
    switch (type) {
      case "1":
        int nextValue;
        phase = (phase + 1) % 9;
        count++;
        switch (phase) {
          case 1:
            nextValue = (40 +
                    random.nextInt(20) *
                        factors[random.nextInt(factors.length)])
                .round();
            break;
          case 2:
            nextValue = (10 +
                    random.nextInt(20) *
                        factors[random.nextInt(factors.length)])
                .round();
            break;
          case 3:
            nextValue = (90 +
                    random.nextInt(20) *
                        factors[random.nextInt(factors.length)])
                .round();
            break;
          case 4:
            nextValue = (10 +
                    random.nextInt(20) *
                        factors[random.nextInt(factors.length)])
                .round();
            break;
          case 5:
            nextValue = (20 +
                    random.nextInt(20) *
                        factors[random.nextInt(factors.length)])
                .round();
            break;
          case 6:
            nextValue = (20 +
                    random.nextInt(20) *
                        factors[random.nextInt(factors.length)])
                .round();
            break;
          case 7:
            nextValue = (60 +
                    random.nextInt(20) *
                        factors[random.nextInt(factors.length)])
                .round();
            break;
          case 8:
            nextValue = (20 +
                    random.nextInt(20) *
                        factors[random.nextInt(factors.length)])
                .round();
            break;
          default:
            nextValue = (20 +
                    random.nextInt(20) *
                        factors[random.nextInt(factors.length)])
                .round();
        }

        data.add(ChartData(DateTime.now(), nextValue, count));
        data.removeAt(0);
        break;
      case "2":
        data2.add(ChartData(DateTime.now(), random.nextInt(100), count));
        data2.removeAt(0);
        break;
      case "3":
        data3.add(ChartData(DateTime.now(), random.nextInt(100), count));
        data3.removeAt(0);
        break;
      default:
        print("Pain");
    }
  }
}
