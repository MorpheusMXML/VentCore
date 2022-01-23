import 'package:get/get.dart';
import 'package:uke_mlab/models/data_models/model_absolute.dart';
import 'package:uke_mlab/models/system_state.dart';
import 'package:uke_mlab/utilities/enums/sensor.dart';
import 'package:uke_mlab/widgets/setting/setting_container.dart';
import 'package:uke_mlab/widgets/setting/ippv_button.dart';

class IppvModel {
  /// offers representation for [SettingContainer] and widgets below

  /// data representation for [SettingContainer] and widgets below
  Map<String, RxInt> ippvValues = {'Freq.': 20.obs, 'Vt': 40.obs, 'PEEP': 60.obs};

  /// contains the string representing to be displayed at [IPPVButton]
  final RxString selectedIPPVMode = 'IPPV'.obs;

  /// updates the current [ippvValues]
  void updateIPPVValue(String name, int value) {
    ippvValues[name]!.value = ippvValues[name]!.value + value;
    if (name == 'Vt') {
      updateMVe();
    } else if (name == 'Freq.') {
      updateVentValues();
    }
  }

  void updateVentValues() {
    Get.find<DataModelAbsolute>(tag: sensorEnumAbsolute.breathfrequency.name)
        .updateValue(ippvValues['Freq.']!.value.toDouble());
    updateMVe();
  }

  void updateMVe() {
    Get.find<DataModelAbsolute>(tag: sensorEnumAbsolute.mve.name)
        .updateValue(((ippvValues['Freq.']!.value * (ippvValues['Vt']!.value / 1000))).toDouble());
    print("${Get.find<SystemState>().alarmState[sensorEnumAbsolute.mve]}");
  }
}
