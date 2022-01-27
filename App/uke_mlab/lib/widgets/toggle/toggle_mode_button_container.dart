import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/models/system_state.dart';
import 'package:uke_mlab/providers/defibrillation_controller.dart';
import 'package:uke_mlab/providers/screen_controller.dart';
import 'package:uke_mlab/widgets/toggle/toggle_mode_button.dart';

/// This class implements the [ToggleButtons] that provide the mode changing functionality.
/// The respective toggle buttons are [ToggleModeButton]s.
///
/// It houses the Buttons for Defibrillator, Ventilator and Monitoring with the corresponding Icons stored in the iconLocationMap.
/// Further gets the Instance of the [SystemState] to  track in which mode the App currently is.
/// Also uses the [DefibrillationController] and [ScreenController] to restrict the availability of this Button during the Load/Shock Animation of the Defi.
///
/// {@category Toggle}
class ToggleModeButtonContainer extends StatelessWidget {
  const ToggleModeButtonContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SystemState systemState = Get.find<SystemState>();

    return Center(
      heightFactor: 2,
      child: Obx(
        () => ToggleButtons(
          children: const <Widget>[
            ToggleModeButton(index: 0, path: 'assets/icons/monitoring.svg'),
            ToggleModeButton(index: 1, path: 'assets/icons/VentilatorIcon.svg'),
            ToggleModeButton(index: 2, path: 'assets/icons/AED.svg'),
          ],
          onPressed: (int index) {
            if (Get.find<DefibrillationController>().toggleButtonAvailable.isTrue) {
              Get.find<ScreenController>().setSelectedToggleView(index);
            }
          },
          isSelected: systemState.selectedToggleView,
        ),
      ),
    );
  }
}
