// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';

class startScreenSlider extends StatefulWidget {
  final String name;
  const startScreenSlider({
    Key? key,
    required this.name,
  }) : super(key: key);

  @override
  _startScreenSlider createState() => _startScreenSlider();
}

class _startScreenSlider extends State<startScreenSlider> {
  double _value = 20;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
      color: const Color(0xff322f37),
      height: 80 / MediaQuery.of(context).devicePixelRatio,
      child: Row(
        children: [
          //Text
          Flexible(
            flex: 2,
            fit: FlexFit.tight,
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                widget.name,
                style: const TextStyle(
                  fontSize: 17,
                  color: Color(0xffeeeeee),
                ),
              ),
            ),
          ),
          //Slider
          Flexible(
            flex: 8,
            child: Slider(
              min: 0.0,
              max: 150.0,
              divisions: 15,
              value: _value,
              label: _value.round().toString(),
              onChanged: (value) {
                setState(() {
                  _value = value;
                });
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 5, 10, 5),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(3))),
            alignment: Alignment.center,
            height: 40 / MediaQuery.of(context).devicePixelRatio,
            width: 90 / MediaQuery.of(context).devicePixelRatio,
            child: Text(_value.round().toString()),
          ),
        ],
      ),
    );
  }
}
