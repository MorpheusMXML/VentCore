import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:uke_mlab/widgets/start_screen/aed_button.dart';
import 'package:uke_mlab/widgets/start_screen/patient_type_button.dart';
import 'package:uke_mlab/widgets/start_screen/continue_button.dart';
import 'package:uke_mlab/widgets/start_screen/details_popup.dart';
import 'package:uke_mlab/widgets/start_screen/skip_button.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<String, String> imageMap = {
      'Adult': 'assets/icons/adults2.svg',
      'Child': 'assets/icons/children.svg',
      'Infant': 'assets/icons/newborn.svg',
    };

    return Row(
      children: [
        Flexible(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:
                // TODO: precache images so loading doesn't take so long
                // https://stackoverflow.com/questions/66872111/
                imageMap.entries
                    .map((entry) => PatientTypeButton(
                          name: entry.key,
                          image: SvgPicture.asset(entry.value, height: 70),
                        ))
                    .toList(),
          ),
        ),
        Flexible(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const DetailsPopup(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    children: const [
                      ContinueButton(),
                      SkipButton(),
                    ],
                  ),
                  const AEDButton(),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
