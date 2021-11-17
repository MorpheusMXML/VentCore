// ignore_for_file: avoid_print, prefer_const_constructors, camel_case_types, use_key_in_widget_constructors, file_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_grid/responsive_grid.dart';

class startScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ResponsiveGridRow(
      children: [
        ResponsiveGridCol(
            md: 6,
            child: Column(children: const [
              startScreenButton(name: 'Adultus'),
              startScreenButton(name: 'Not Adult'),
              startScreenButton(name: 'Neither Adult'),
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
      ),
    );
  }
}
