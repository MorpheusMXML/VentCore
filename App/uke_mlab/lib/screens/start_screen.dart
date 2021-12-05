// ignore_for_file: avoid_print, prefer_const_constructors, camel_case_types, use_key_in_widget_constructors, file_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uke_mlab/widgets/start_screen/name_field.dart';
import 'package:uke_mlab/widgets/start_screen/slider.dart';
import 'package:uke_mlab/widgets/start_screen/start_screen_button.dart';
import 'package:uke_mlab/widgets/start_screen/start_screen_continue.dart';
import 'package:uke_mlab/widgets/start_screen/start_screen_skip.dart';
import 'package:uke_mlab/widgets/statusbar.dart';

class startScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const StatusBar(category: "")),
      body: Row(children: [
        Flexible(
          flex: 5,
          child: Row(
            children: [
              Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    StartScreenButton(
                        name: 'Adult', image: 'assets/icons/adults2.svg'),
                    StartScreenButton(
                        name: 'Children', image: 'assets/icons/children.svg'),
                    StartScreenButton(
                        name: 'Infant', image: 'assets/icons/newborn.svg'),
                  ]),
            ],
          ),
        ),
        Flexible(
          flex:
              3, //von 4 auf 3 damit Patientencontainer wieder auf eine höhe mit Buttons
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              //Ganzer Container auf einer Höhe mit Buttons darunter
              Align(
                alignment: Alignment.centerRight,
                //Fetter Container
                child: Container(
                  margin: const EdgeInsets.fromLTRB(0, 0, 65, 12),
                  color: Color(0xff25232a),
                  height: 320 / MediaQuery.of(context).devicePixelRatio,
                  width: 830 / MediaQuery.of(context).devicePixelRatio,
                  child: Column(
                    //TODO: implement Logic in these 3 Widgets so that we can work with this data in the following
                    children: const [
                      nameField(),
                      startScreenSlider(name: "Weight"),
                      startScreenSlider(name: "Height"),
                    ],
                  ),
                ),
              ),
              StartScreenContinue(),
              StartScreenSkip()
            ],
          ),
        ),
      ]),
    );
  }
}
