import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//Widget for StartScreen Buttons
//@param name Buttontext
//@param optional image SVG asset path
// ignore_for_file: camel_case_types, avoid_print

class DemoScreenButton extends StatelessWidget {
  final String name;
  const DemoScreenButton({
    Key? key,
    required this.name,
  }): super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      //Button style
      margin: const EdgeInsets.fromLTRB(65, 0, 0, 12),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          fixedSize: Size(800 / MediaQuery.of(context).devicePixelRatio,
              155 / MediaQuery.of(context).devicePixelRatio),
          primary: const Color(0xffeeeeee),
          onPrimary: Colors.black,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(75)),
        ),
        //Presets Loading
        onPressed: () {
          print(name);
        },
        //Button content
        child: Text(
          name,
          style: const TextStyle(fontSize: 25),
        ),
      ),
    );
  }
}
