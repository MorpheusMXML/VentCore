import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uke_mlab/widgets/demo_screen_button.dart';

class DemoScreen extends StatelessWidget {
  const DemoScreen({
    Key? key,
  }) : super(key: key);

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
                  DemoScreenButton(name: "Demo Scenario 1"),
                  DemoScreenButton(name: "Demo Scenario 2"),
                  DemoScreenButton(name: "Demo Scenario 3"),
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
