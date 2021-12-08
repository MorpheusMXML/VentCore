import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uke_mlab/widgets/demo_screen/demo_screen_button.dart';
import 'package:uke_mlab/widgets/demo_screen/demo_screen_exit.dart';
import 'package:uke_mlab/widgets/statusbar.dart';

class DemoScreen extends StatelessWidget {
  const DemoScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const StatusBar(category: "")),
      body: Row(children: [
        Flexible(
          flex: 3,
          child: Row(
            children: [
              Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    DemoScreenButton(name: "Scenario 1"),
                    DemoScreenButton(name: "Scenario 2"),
                    DemoScreenButton(name: "Scenario 3"),
                    DemoScreenButton(name: "Scenario 4"),
                  ]),
            ],
          ),
        ),
        Flexible(
          flex: 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: const [
              DemoScreenExit(),
            ],
          ),
        ),
      ]),
    );
  }
}
