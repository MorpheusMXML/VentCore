import 'package:flutter/material.dart';

class StatusBar extends StatelessWidget {
  const StatusBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        Flexible(
          flex: 1,
          child: Icon(Icons.menu, color: Colors.white),
        ),
        Flexible(
          flex: 5,
          child: Text(
            "Alert Message",
            style:
                TextStyle(color: Colors.white, decoration: TextDecoration.none),
          ),
        ),
        Flexible(
          flex: 1,
          child: Text(
            "Adult",
            style:
                TextStyle(color: Colors.white, decoration: TextDecoration.none),
          ),
        ),
        Flexible(
          flex: 1,
          child: Text(
            "19:11",
            style:
                TextStyle(color: Colors.white, decoration: TextDecoration.none),
          ),
        ),
        Flexible(
          flex: 1,
          child: Icon(Icons.battery_full, color: Colors.white),
        )
      ],
    );
  }
}
