// ignore_for_file: avoid_print, prefer_const_constructors, camel_case_types, use_key_in_widget_constructors, file_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:flutter_svg/flutter_svg.dart';
import 'package:responsive_grid/responsive_grid.dart';


=======
import 'package:responsive_grid/responsive_grid.dart';

>>>>>>> a555e76 ([Task] #29 Adding Start Screen first draft)
class startScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ResponsiveGridRow(
<<<<<<< HEAD
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ResponsiveGridCol(
            md: 6,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
              startScreenButton(name: 'Adult', image: 'lib/src/assets/icons/children.svg'),
              startScreenButton(name: 'Children', image: 'lib/src/assets/icons/children.svg'),
              startScreenButton(name: 'Infant', image: 'lib/src/assets/icons/newborn.svg'),
=======
      children: [
        ResponsiveGridCol(
            md: 6,
            child: Column(children: const [
              startScreenButton(name: 'Adultus'),
              startScreenButton(name: 'Not Adult'),
              startScreenButton(name: 'Neither Adult'),
>>>>>>> a555e76 ([Task] #29 Adding Start Screen first draft)
            ])),
        ResponsiveGridCol(
          md: 6,
          child: Container(
            height: 100,
          ),
        ),
      ],
    );
  }
}

class startScreenButton extends StatelessWidget {
  final String name;
<<<<<<< HEAD
  final String image;
  const startScreenButton({
    required this.name,
    required this.image,
  });
  @override
  Widget build(BuildContext context) {
      return Container(
        margin: EdgeInsets.only(bottom: 12.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            fixedSize: Size (800/MediaQuery.of(context).devicePixelRatio, 155/MediaQuery.of(context).devicePixelRatio),
            primary: Color(0xffeeeeee),
            onPrimary: Colors.black,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(75)),
          ),
          onPressed: (){ print (name);},
          child: Row(
            children: [
              Expanded(
                flex: 4,
                child: SvgPicture.asset(image, height: 65,)),
              Expanded(
                flex: 5,
                child: Text(
                  name, 
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 25))),
              Expanded(
                flex: 4,
                child: Container(), //Fynn bitte nicht töten, wir wissen nicht wie sonst :(
                ),
            ],
          ),
=======
  const startScreenButton({
    required this.name,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(75), color: Color(0xffeeeeee)),
      margin: const EdgeInsets.only(bottom: 12.0),
      width: 800,
      height: 155,
      child: ElevatedButton(
        onPressed: null,
        child: Text(name),
>>>>>>> a555e76 ([Task] #29 Adding Start Screen first draft)
      ),
    );
  }
}
