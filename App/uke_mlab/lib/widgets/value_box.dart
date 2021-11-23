import 'package:flutter/material.dart';

class ValueBox extends StatelessWidget {
  final int textColor;
  // To be changed to "actual" data
  final int value;
  final String miniTitle;

  const ValueBox({
    Key? key,
    required this.textColor,
    // To be changed to "actual" data
    required this.value,
    this.miniTitle = "PP",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8, bottom: 4, left: 4, right: 4),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                miniTitle,
                style: TextStyle(color: Color(textColor)),
              ),
              const Padding(padding: EdgeInsets.only(left: 70, right: 50)),
              Text(
                "120",
                style: TextStyle(
                  // doesn't work here for some reason
                  //overflow: TextOverflow.ellipsis,
                  color: Color(textColor),
                ),
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
          Text(
            value.toString(),
            style: TextStyle(
              color: Color(textColor),
              fontSize: 80,
            ),
          ),
          Row(
            children: [
              Text(
                "58",
                style: TextStyle(
                  color: Color(textColor),
                ),
              ),
              const Padding(padding: EdgeInsets.only(left: 70, right: 50)),
              Text(
                "1/ min.",
                style: TextStyle(
                  color: Color(textColor),
                ),
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        ],
      ),
    );
  }
}
