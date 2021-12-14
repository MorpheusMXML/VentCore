import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ModeToggleButton extends StatefulWidget {
  const ModeToggleButton({Key? key}) : super(key: key);

  @override
  _ModeToggleButtonState createState() => _ModeToggleButtonState();
}

class _ModeToggleButtonState extends State<ModeToggleButton> {
  final List<bool> isSelected = [true, false, false];
  final Map<String, String> iconLocationMap = {
    'Monitoring': 'assets/icons/monitoring.svg',
    'Ventilation': 'assets/icons/VentilatorIcon.svg',
    'Defibrillator': 'assets/icons/AED.svg',
  };
  final Color background = const Color(0xFF2A2831);
  final Color inactiveIcon = const Color(0xFF79747E);
  final Color active = const Color(0xFF5D5FEF);

  @override
  Widget build(BuildContext context) {
    return Center(
        heightFactor: 2,
        child: ToggleButtons(
          borderColor: Colors.grey[800],
          borderWidth: 0.5,
          selectedBorderColor: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(25)),
          children: <Widget>[
            Container(
                decoration: BoxDecoration(color: isSelected[0] ? active : background),
                width: 100,
                child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: SvgPicture.asset(
                      iconLocationMap['Monitoring'].toString(),
                      height: 40.0,
                      color: isSelected[0] ? Colors.white : inactiveIcon,
                    ))),
            Container(
                decoration: BoxDecoration(color: isSelected[1] ? active : background),
                width: 100,
                child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: SvgPicture.asset(
                      iconLocationMap['Ventilation'].toString(),
                      height: 40.0,
                      color: isSelected[1] ? Colors.white : inactiveIcon,
                    ))),
            Container(
                decoration: BoxDecoration(color: isSelected[2] ? active : background),
                width: 100,
                child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: SvgPicture.asset(
                      iconLocationMap['Defibrillator'].toString(),
                      height: 40.0,
                      color: isSelected[2] ? Colors.white : inactiveIcon,
                    ))),
          ],
          onPressed: (int index) {
            //TODO: Implement Behaviour that should be called upon ToggleButtonPress

            setState(() {
              for (int buttonIndex = 0; buttonIndex < isSelected.length; buttonIndex++) {
                if (buttonIndex == index) {
                  isSelected[buttonIndex] = true;
                } else {
                  isSelected[buttonIndex] = false;
                }
              }
            });
          },
          isSelected: isSelected,
        ));
  }
}
