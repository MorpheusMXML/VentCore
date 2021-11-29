import 'package:flutter/material.dart';

class ValueBox extends StatelessWidget {
  final Color textColor;
  final int value;
  final int backgroundColor;
  final String miniTitle;

  const ValueBox({
    Key? key,
    required this.textColor,
    required this.value,
    // to be changed
    this.miniTitle = "PP",
    required this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void _showSnack() => ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("Button Tapped")));

    return ElevatedButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all(const RoundedRectangleBorder()),
        backgroundColor: MaterialStateProperty.all(Color(backgroundColor)),
      ),
      onPressed: _showSnack,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                miniTitle,
                style: TextStyle(color: textColor),
              ),
              Text(
                // to be changed
                "120",
                style: TextStyle(
                  color: textColor,
                ),
              ),
            ],
          ),
          Text(
            value.toString(),
            style: TextStyle(
              color: textColor,
              fontSize: 80,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                // to be changed
                "58",
                style: TextStyle(color: textColor),
                textAlign: TextAlign.left,
              ),
              Text(
                // to be changed
                "1/ min.",
                style: TextStyle(
                  color: textColor,
                ),
                textAlign: TextAlign.right,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
