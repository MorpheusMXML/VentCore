import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/models/system_state.dart';
import 'package:uke_mlab/providers/defibrillation_controller.dart';
import 'package:uke_mlab/providers/screen_controller.dart';
import 'package:uke_mlab/utilities/app_theme.dart';

/// This Class implements the [ToggleButtons] that provide the Mode Changing Functionality.
///
/// It houses the Buttons for Defibrillator, Ventilator and Monitoring with the corresponding Icons stored in the [iconLocationMap].
/// Further gets the Instance of the [SystemState] to  track in which mode the App currently is.
/// Also uses the [DefibrillationController] and [ScreenController] to restrict the availability of this Button during the Load/Shock Animation of the Defi.
///
class ToggleModeButton extends StatelessWidget {
  ToggleModeButton({Key? key}) : super(key: key);

  final SystemState systemState = Get.find<SystemState>();
  final Map<String, String> iconLocationMap = {
    'Monitoring': 'assets/icons/monitoring.svg',
    'Ventilation': 'assets/icons/VentilatorIcon.svg',
    'Defibrillator': 'assets/icons/AED.svg',
  };

  // eventually move to theme class
  final Color inactiveIcon = const Color(0xFF79747E);
  final Color active = const Color(0xFF5D5FEF);

  @override
  Widget build(BuildContext context) {
    return Center(
      heightFactor: 2,
      child: Obx(
        () => ToggleButtons(
          children: <Widget>[
            getToggleButton(
                0, iconLocationMap['Monitoring'].toString(), context),
            getToggleButton(
                1, iconLocationMap['Ventilation'].toString(), context),
            getToggleButton(
                2, iconLocationMap['Defibrillator'].toString(), context),
          ],
          onPressed: (int index) {
            if (Get.find<DefibrillationController>()
                .toggleButtonAvailable
                .isTrue) {
              Get.find<ScreenController>().setSelectedToggleView(index);
            }
          },
          isSelected: systemState.selectedToggleView,
        ),
      ),
    );
  }

  getToggleButton(int index, String path, BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
          color: systemState.selectedToggleView[index]
              ? active
              : theme.primarySwatch[40]),
      width: 100,
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: SvgPicture.asset(
          path,
          height: 40.0,
          color: systemState.selectedToggleView[index]
              ? theme.contrastColor
              : inactiveIcon,
        ),
      ),
    );
  }
}
