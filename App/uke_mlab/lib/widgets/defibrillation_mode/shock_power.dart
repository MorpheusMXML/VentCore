import 'package:flutter/material.dart';

class ShockPower extends StatelessWidget {
  const ShockPower({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).shadowColor,
      child: Row(
        children: const [
          Flexible(
            flex: 3,
            child: Text("Shock Power"),
          ),
          Flexible(
            flex: 2,
            child: Text("200"),
          ),
          Flexible(
            flex: 1,
            child: Text("J"),
          )
        ],
      ),
    );
  }
}
