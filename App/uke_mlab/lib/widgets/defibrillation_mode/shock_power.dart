import 'package:flutter/material.dart';

class ShockPower extends StatelessWidget {
  const ShockPower({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        color: Theme.of(context).shadowColor,
        margin: const EdgeInsets.only(left: 8, right: 8),
        child: Row(
          children: const [
            Expanded(
              flex: 3,
              child: Text("Shock Power"),
            ),
            Expanded(
              flex: 2,
              child: Text("200"),
            ),
            Expanded(
              flex: 1,
              child: Text("J"),
            )
          ],
        ),
      ),
    );
  }
}
