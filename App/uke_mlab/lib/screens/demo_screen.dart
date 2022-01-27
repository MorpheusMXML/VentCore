import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uke_mlab/utilities/enums/scenarios.dart';
import 'package:uke_mlab/widgets/demo_screen/scenario_button.dart';
import 'package:uke_mlab/widgets/demo_screen/exit_button.dart';

/// Lists all available scenarios and enables the user to start them on click.
///
/// {@category Screens}
class DemoScreen extends StatelessWidget {
  const DemoScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          flex: 3,
          child: Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  ScenarioButton(
                    name: 'Standard Scenario',
                    scenario: scenariosEnum.standardScenario,
                  ),
                  ScenarioButton(name: 'Scenario 1', scenario: scenariosEnum.scenario1),
                  ScenarioButton(name: 'Scenario 2', scenario: scenariosEnum.scenario2),
                  ScenarioButton(name: 'Scenario 3a', scenario: scenariosEnum.scenario3a),
                  ScenarioButton(name: 'Scenario 3b', scenario: scenariosEnum.scenario3b),
                  ScenarioButton(name: 'Scenario 3c', scenario: scenariosEnum.scenario3c),
                  ScenarioButton(name: 'Scenario 4', scenario: scenariosEnum.scenario4),
                ],
              ),
            ],
          ),
        ),
        Flexible(
          flex: 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: const [
              ExitButton(),
            ],
          ),
        ),
      ],
    );
  }
}
