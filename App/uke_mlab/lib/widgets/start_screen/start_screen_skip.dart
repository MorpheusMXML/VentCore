import 'package:flutter/material.dart';

class startScreenSkip extends StatelessWidget {
  const startScreenSkip({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      margin: const EdgeInsets.fromLTRB(0, 0, 65, 12),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          fixedSize: Size(250 / MediaQuery.of(context).devicePixelRatio,
              80 / MediaQuery.of(context).devicePixelRatio),
          primary: const Color(0xffeeeeee),
          onPrimary: Colors.black,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(75)),
        ),
        child: const Text('Skip', style: TextStyle(fontSize: 20)),
        onPressed: () {},
      ),
    );
  }
}
