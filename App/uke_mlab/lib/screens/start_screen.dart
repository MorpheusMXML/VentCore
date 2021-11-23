// ignore_for_file: avoid_print, prefer_const_constructors, camel_case_types, use_key_in_widget_constructors, file_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uke_mlab/widgets/aed_button.dart';
import 'package:uke_mlab/widgets/start_screen/name_field.dart';
import 'package:uke_mlab/widgets/start_screen/slider.dart';
import 'package:uke_mlab/widgets/start_screen/start_screen_button.dart';
import 'package:uke_mlab/widgets/start_screen/start_screen_skip.dart';

class startScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Flexible(
        flex: 5,
        child: Row(
          children: [
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  startScreenButton(
                      name: 'Adult', image: 'assets/icons/adults2.svg'),
                  startScreenButton(
                      name: 'Children', image: 'assets/icons/children.svg'),
                  startScreenButton(
                      name: 'Infant', image: 'assets/icons/newborn.svg'),
                ]),
          ],
        ),
      ),
      Flexible(
        flex: 4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              //Fett
              margin: const EdgeInsets.fromLTRB(0, 0, 65, 12),
              color: Color(0xff25232a),
              height: 320 / MediaQuery.of(context).devicePixelRatio,
              width: 830 / MediaQuery.of(context).devicePixelRatio,
              child: Column(
                children: [
                  nameField(),
                  startScreenSlider(),
                ],
              ),
            ),
            aedButton(),
            startScreenSkip()
          ],
        ),
      ),
    ]);
  }
}
