import 'package:get/get.dart';
import 'package:uke_mlab/widgets/setting/setting_container.dart';
import 'package:uke_mlab/widgets/setting/ippv_button.dart';

class IppvModel {
  /// offers representation for [SettingContainer] and widgets below

  /// data representation for [SettingContainer] and widgets below
  Map<String, RxInt> ippvValues = {
    'Freq.': 20.obs,
    'Vt': 40.obs,
    'PEEP': 60.obs
  };

  /// contains the string representing to be displayed at [IPPVButton]
  final RxString selectedIPPVMode = 'Mode 1'.obs;

  /// updates the current [ippvValues]
  void updateIPPVValue(String name, int value) {
    ippvValues[name]!.value = ippvValues[name]!.value + value;
  }
}
