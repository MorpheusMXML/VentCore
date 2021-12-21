import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uke_mlab/widgets/start_screen/aed_button.dart';
import 'package:uke_mlab/widgets/start_screen/start_screen_button.dart';
import 'package:uke_mlab/widgets/start_screen/start_screen_continue.dart';
import 'package:uke_mlab/widgets/start_screen/start_screen_popup.dart';
import 'package:uke_mlab/widgets/start_screen/start_screen_skip.dart';
import 'package:uke_mlab/widgets/statusbar/statusbar.dart';

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
            children: const [
              StartScreenButton(
                  name: 'Adult', image: 'assets/icons/adults2.svg'),
              StartScreenButton(
                  name: 'Child', image: 'assets/icons/children.svg'),
              StartScreenButton(
                  name: 'Infant', image: 'assets/icons/newborn.svg'),
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
