import 'package:get/get.dart';

class IppvModel {
  Map<String, RxInt> ippvValues = {
    'Freq.': 20.obs,
    'Vt': 40.obs,
    'PEEP': 60.obs
  };

  final RxBool ippvTapped = false.obs;
  final RxString selectedIPPVMode = 'Mode 1'.obs;

  void updateIPPVValue(String name, int value) {
    ippvValues[name]!.value = ippvValues[name]!.value + value;
  }
}
