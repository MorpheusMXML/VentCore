import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/utilities/enums/scenarios.dart';
import 'package:uke_mlab/providers/screen_controller.dart';

//Widget for StartScreen Buttons
//@param name Buttontext

class ScenarioButton extends StatelessWidget {
  final String name;
  final scenariosEnum scenario;
  const ScenarioButton({
    Key? key,
    required this.name,
    required this.scenario,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ScreenController screenController = Get.find<ScreenController>();

    return Container(
      //Button style
      margin: const EdgeInsets.fromLTRB(65, 0, 0, 12),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          fixedSize: Size(800 / MediaQuery.of(context).devicePixelRatio,
              155 / MediaQuery.of(context).devicePixelRatio),
          primary: const Color(0xffeeeeee),
          onPrimary: Colors.black,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(75)),
        ),
        //TODO: Scenario Loading
        onPressed: () => screenController.scenarioButton(scenario),
        //Button content
        child: Text(
          name,
          style: const TextStyle(fontSize: 25),
        ),
      ),
    );
  }
}
