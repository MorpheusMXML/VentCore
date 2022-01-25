import 'package:get/get.dart';
import 'package:uke_mlab/models/data_models/model_absolute.dart';
import 'package:uke_mlab/models/system_state.dart';
import 'package:uke_mlab/utilities/enums/patient_type.dart';
import 'package:uke_mlab/utilities/enums/sensor.dart';
import 'package:uke_mlab/widgets/setting/setting_container.dart';
import 'package:uke_mlab/widgets/setting/ippv_button.dart';

/// offers representation for [SettingContainer] and widgets below
class IppvModel {
  /// default data values for [SettingContainer] and widgets below
  Map<String, int> defaultIppvValues = {'Freq.': 15, 'Vt': 300, 'PEEP': 60};

  /// data representation for [SettingContainer] and widgets below
  late final Map<String, RxInt> ippvValues;

  /// contains the string representing to be displayed at [IPPVButton]
  final RxString selectedIPPVMode = 'IPPV'.obs;

  IppvModel() {
    ippvValues = {'Freq.': defaultIppvValues['Freq.']!.obs, 'Vt': defaultIppvValues['Vt']!.obs, 'PEEP': defaultIppvValues['PEEP']!.obs};
  }

  /// updates the current [ippvValues]
  ///
  /// [value] is required to be 1 or -1
  void updateIPPVValue(String name, int value) {
    SystemState systemState = Get.find<SystemState>();
    int newValue = ippvValues[name]!.value;

    if (name == "Freq.") {
      newValue += value;
    } else if (name == "Vt") {
      switch (systemState.patientType) {
        case patientTypeEnum.adult:
          newValue += 10 * value;
          break;
        case patientTypeEnum.child:
        case patientTypeEnum.infant:
          newValue += 5 * value;
          break;
        default:
          throw Exception("Patient type not valid (most likely patientTypeEnum.none) during updateIPPVValue");
      }
    } else if (name == "PEEP") {
      newValue += 5 * value;
    } else {
      throw Exception("name was $name during updateIPPVValue which is no valid IPPv name");
    }

    ippvValues[name]!.value = newValue;
    if (name == 'Vt') {
      updateMVe();
    } else if (name == 'Freq.') {
      updateVentValues();
    }
  }

  void updateVentValues() {
    Get.find<DataModelAbsolute>(tag: sensorEnumAbsolute.breathfrequency.name).updateValue(ippvValues['Freq.']!.value.toDouble());
    updateMVe();
  }

  void updateMVe() {
    Get.find<DataModelAbsolute>(tag: sensorEnumAbsolute.mve.name).updateValue(((ippvValues['Freq.']!.value * (ippvValues['Vt']!.value / 1000))).toDouble());
  }

  resetIPPV() {
    ippvValues['Freq.']!.value = defaultIppvValues['Freq.']!;
    ippvValues['Vt']!.value = defaultIppvValues['Vt']!;
    ippvValues['PEEP']!.value = defaultIppvValues['PEEP']!;
  }
}
