import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

//Widget for StartScreen Buttons
//@param name Buttontext
//@param optional image SVG asset path
// ignore_for_file: camel_case_types, avoid_print

class startScreenButton extends StatelessWidget {
  final String name;
  final String image;
  const startScreenButton({
    required this.name,
    required this.image,
  });
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
        child: Row(
          children: [
            Flexible(
                flex: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      image,
                      height: 70,
                    ),
                  ],
                )),
            Flexible(
              flex: 3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    name,
                    style: const TextStyle(fontSize: 25),
                  ),
                ],
              ),
            ),
            Flexible(
              flex: 2,
              child: Container(), //Leer damit Button Text zentriert
            ),
          ],
        ),
      ),
    );
  }
}
