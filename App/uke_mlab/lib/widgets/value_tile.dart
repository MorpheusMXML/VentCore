import 'package:flutter/material.dart';
import 'package:uke_mlab/widgets/value_box.dart';

class ValueTile extends StatelessWidget {
  final Color textColor;
  final Color backgroundColor;
  final int value;
  final String name;

  const ValueTile({
    Key? key,
    required this.textColor,
    required this.name,
    required this.backgroundColor,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        color: backgroundColor,
        margin: const EdgeInsets.only(right: 8, bottom: 8),
        child: Column(
          children: [
            Flexible(
              flex: 1,
              child: Container(
                margin: const EdgeInsets.only(top: 4, bottom: 4),
                child: Text(
                  name,
                  style: TextStyle(
                    decoration: TextDecoration.none,
                    color: textColor,
                    fontSize: 40,
                    // temp fix for long names
                    overflow: TextOverflow.ellipsis,
                  ),
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
