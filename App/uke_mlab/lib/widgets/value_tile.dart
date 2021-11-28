import 'package:flutter/material.dart';
import 'package:uke_mlab/widgets/value_box.dart';

class ValueTile extends StatelessWidget {
  final int textColor;
  final int backgroundColor;
  final int value;
  final String name;

  const ValueTile({
    Key? key,
    required this.textColor,
    required this.name,
    required this.backgroundColor,
    this.value = 78,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        color: Color(backgroundColor),
        margin: const EdgeInsets.only(right: 8, bottom: 8),
        child: Column(
          children: [
            Flexible(
              flex: 1,
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
            Flexible(
              // cant decrease --> pixel overflow
              flex: 3,
              child: ValueBox(
                backgroundColor: backgroundColor,
                textColor: textColor,
                value: value,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
