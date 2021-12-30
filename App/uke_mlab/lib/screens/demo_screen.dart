import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uke_mlab/widgets/demo_screen/scenario_button.dart';
import 'package:uke_mlab/widgets/demo_screen/exit_button.dart';

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
                  ScenarioButton(name: 'Scenario 1'),
                  ScenarioButton(name: 'Scenario 2'),
                  ScenarioButton(name: 'Scenario 3'),
                  ScenarioButton(name: 'Scenario 4'),
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
