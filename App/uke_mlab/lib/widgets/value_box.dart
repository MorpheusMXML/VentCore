import 'package:flutter/material.dart';

class ValueBox extends StatelessWidget {
  final int textColor;
  // To be changed to "actual" data
  final int value;
  final int backgroundColor;
  final String miniTitle;

  const ValueBox({
    Key? key,
    required this.textColor,
    // To be changed to "actual" data
    required this.value,
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
            children: [
              Flexible(
                flex: 1,
                child: SizedBox(
                  width: double.maxFinite,
                  child: Text(
                    miniTitle,
                    style: TextStyle(color: Color(textColor)),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: SizedBox(
                  width: double.maxFinite,
                  child: Text(
                    "120",
                    style: TextStyle(
                      // doesn't work here for some reason
                      //overflow: TextOverflow.ellipsis,
                      color: Color(textColor),
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
              ),
            ],
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
              Flexible(
                flex: 1,
                child: SizedBox(
                  width: double.maxFinite,
                  child: Text(
                    "58",
                    style: TextStyle(color: Color(textColor)),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: SizedBox(
                  width: double.maxFinite,
                  child: Text(
                    "1/ min.",
                    style: TextStyle(
                      // doesn't work here for some reason
                      //overflow: TextOverflow.ellipsis,
                      color: Color(textColor),
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
