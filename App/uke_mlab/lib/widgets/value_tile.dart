import 'package:flutter/material.dart';
import 'package:uke_mlab/widgets/value_box.dart';

class ValueTile extends StatelessWidget {
  final int textColor;
  final int backgroundColor;
  final int value;
  final String name;

  const ValueTile({
    required this.textColor,
    required this.name,
    required this.backgroundColor,
    this.value = 78,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(backgroundColor),
      margin: const EdgeInsets.all(12),
      width: double.maxFinite,
      child: Column(children: [
        Container(
          // This margin causes the Text to be pushed away from the edge of the container.
          margin: const EdgeInsets.only(top: 12, left: 12, right: 12),
          child: Text(
            name,
            style: TextStyle(
              color: Color(textColor),
              fontSize: 40,
              // temp fix for long names
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        ValueBox(
          textColor: textColor,
          value: value,
        ),
      ]),
    );
  }
}
