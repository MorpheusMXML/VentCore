// ignore_for_file: avoid_print, prefer_const_constructors, camel_case_types, use_key_in_widget_constructors, file_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uke_mlab/widgets/start_screen_button.dart';

class startScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Flexible(
        flex: 3,
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
        flex: 2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              height: 100,
              color: Colors.amber,
            )
          ],
        ),
      ),
    ]);
  }
}
