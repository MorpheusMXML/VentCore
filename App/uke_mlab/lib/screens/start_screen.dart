import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/providers/start_screen_controller.dart';
import 'package:uke_mlab/widgets/start_screen/name_field.dart';
import 'package:uke_mlab/widgets/start_screen/slider_tile.dart';
import 'package:uke_mlab/widgets/start_screen/start_screen_button.dart';
import 'package:uke_mlab/widgets/start_screen/start_screen_continue.dart';
import 'package:uke_mlab/widgets/start_screen/start_screen_skip.dart';
import 'package:uke_mlab/widgets/statusbar.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final startScreenController = Get.find<StartScreenController>();
    return Scaffold(
      appBar: AppBar(title: const StatusBar(category: "")),
      body: Row(children: [
        Flexible(
          flex: 5,
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
                  color: const Color(0xff25232a),
                  height: 320 / MediaQuery.of(context).devicePixelRatio,
                  width: 830 / MediaQuery.of(context).devicePixelRatio,
                  child: Column(
                    //TODO: implement Logic in these 3 Widgets so that we can work with this data in the following
                    children: [
                      const nameField(),
                      SliderTile(
                          name: "Weight",
                          value: startScreenController.weightValue),
                      SliderTile(
                          name: "Height",
                          value: startScreenController.heightValue),
                    ],
                  ),
                ),
              ),
              const StartScreenContinue(),
              const StartScreenSkip()
            ],
          ),
        ),
      ]),
    );
  }
}
