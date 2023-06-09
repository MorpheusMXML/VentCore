import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/utilities/app_theme.dart';
import 'package:uke_mlab/utilities/enums/scenarios.dart';
import 'package:uke_mlab/providers/screen_controller.dart';

/// Widget for StartScreen Buttons
///
/// {@category DemoScreen}
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
    final ThemeData theme = Theme.of(context);
    final ScreenController screenController = Get.find<ScreenController>();

    return Container(
      margin: const EdgeInsets.fromLTRB(65, 0, 0, 12),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          fixedSize: Size(800 / MediaQuery.of(context).devicePixelRatio,
              155 / MediaQuery.of(context).devicePixelRatio),
          primary: theme.primarySwatch[10],
          onPrimary: theme.inverseContrastColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(75)),
        ),
        onPressed: () => screenController.scenarioButton(scenario),
        child: Text(
          name,
          style:theme.navigationButtonTextStyle,
        ),
      ),
    );
  }
}
