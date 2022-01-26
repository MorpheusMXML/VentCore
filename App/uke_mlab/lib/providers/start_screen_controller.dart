import 'package:get/get.dart';
import 'package:uke_mlab/screens/start_screen.dart';
import 'package:uke_mlab/widgets/start_screen/patient_type_button.dart';

/// Controller for the [StartScreen]
///
/// Contains default weights and heights for adult, child and infant as well as the ability to change them
class StartScreenController extends GetxController {
  /// Name of the patient
  RxString selectedString = ''.obs;

  /// Weight of the patient
  RxDouble weightValue = 75.0.obs;

  /// Height of the patient
  RxDouble heightValue = 175.0.obs;

  /// Controlls whether the settings for a patient type are visible or not.
  RxBool isPopupVisible = false.obs;

  /// Button behavior of clicking on [PatientTypeButton]
  void settingsButton(String name) {
    switch (name) {
      case 'Child':
        selectedString.value = name;
        weightValue.value = 45.0;
        heightValue.value = 155.0;
        break;
      case 'Infant':
        selectedString.value = name;
        weightValue.value = 10.0;
        heightValue.value = 85.0;
        break;
      default:
        selectedString.value = name;
        weightValue.value = 75.0;
        heightValue.value = 175.0;
        break;
    }

    isPopupVisible.value = true;
  }

  /// Manipulates [heightValue] and [weightValue]
  setValue(newValue, name) {
    switch (name) {
      case 'Height':
        heightValue.value = newValue;
        break;
      default:
        weightValue.value = newValue;
        break;
    }
  }
}
