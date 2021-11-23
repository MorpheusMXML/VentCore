import 'package:flutter/material.dart';
import 'package:uke_mlab/widgets/value_box.dart';

class ValueTile extends StatelessWidget {
  final int textColor;

  const ValueTile({
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xff2A2831),
      margin: const EdgeInsets.all(10),
      width: double.maxFinite,
      child: Column(children: [
        Text(
          "78",
          style: TextStyle(
            color: Color(textColor),
          ),
          textScaleFactor: 2.0,
        ),
        const ValueBox(),
      ]),
    );
  }
}
