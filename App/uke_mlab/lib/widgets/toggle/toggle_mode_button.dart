import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/providers/toggle_controller.dart';

class ToggleModeButton extends StatelessWidget {
  ToggleModeButton({Key? key}) : super(key: key);

  final toggleController = Get.find<ToggleController>();
  final Map<String, String> iconLocationMap = {
    'Monitoring': 'assets/icons/monitoring.svg',
    'Ventilation': 'assets/icons/VentilatorIcon.svg',
    'Defibrillator': 'assets/icons/AED.svg',
  };

  // eventually move to theme class
  final Color background = const Color(0xFF2A2831);
  final Color inactiveIcon = const Color(0xFF79747E);
  final Color active = const Color(0xFF5D5FEF);

  @override
  Widget build(BuildContext context) {
    return Center(
      heightFactor: 2,
      child: Obx(
        () => ToggleButtons(
          borderColor: Colors.grey[800],
          borderWidth: 0.5,
          selectedBorderColor: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(25)),
          children: <Widget>[
            getToggleButton(
              0,
              iconLocationMap['Monitoring'].toString(),
            ),
            getToggleButton(
              1,
              iconLocationMap['Ventilation'].toString(),
            ),
            getToggleButton(
              2,
              iconLocationMap['Defibrillator'].toString(),
            ),
          ],
          onPressed: (int index) {
            toggleController.setSelected(index);
          },
          isSelected: toggleController.isSelected,
        ),
      ),
    );
  }

  getToggleButton(int index, String path) {
    return Container(
      decoration: BoxDecoration(
          color: toggleController.isSelected[index] ? active : background),
      width: 100,
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: SvgPicture.asset(
          path,
          height: 40.0,
          color:
              toggleController.isSelected[index] ? Colors.white : inactiveIcon,
        ),
      ),
    );
  }
}
