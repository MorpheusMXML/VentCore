import 'package:flutter/material.dart';

class ExampleFlexible extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      child: Container(
        color: Colors.green,
        margin: const EdgeInsets.fromLTRB(50, 20, 50, 20),
      ),
    );
  }
}
