import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:uke_mlab/widgets/start_screen/aed_button.dart';
import 'package:uke_mlab/widgets/start_screen/start_screen_button.dart';
import 'package:uke_mlab/widgets/start_screen/start_screen_continue.dart';
import 'package:uke_mlab/widgets/start_screen/start_screen_popup.dart';
import 'package:uke_mlab/widgets/start_screen/start_screen_skip.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          flex: 1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // precache images so loading doesn't take so long
              // https://stackoverflow.com/questions/66872111/
              StartScreenButton(
                  name: 'Adult',
                  image: SvgPicture.asset(
                    'assets/icons/adults2.svg',
                    height: 70,
                  )),
              StartScreenButton(
                  name: 'Child',
                  image: SvgPicture.asset(
                    'assets/icons/children.svg',
                    height: 70,
                  )),
              StartScreenButton(
                  name: 'Infant',
                  image: SvgPicture.asset(
                    'assets/icons/newborn.svg',
                    height: 70,
                  )),
            ],
          ),
        ),
        Flexible(
          flex: 1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const StartScreenPopup(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    children: const [
                      StartScreenContinue(),
                      StartScreenSkip(),
                    ],
                  ),
                  const aedButton(),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
