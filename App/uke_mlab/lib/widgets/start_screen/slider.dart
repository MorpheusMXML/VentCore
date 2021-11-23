import 'package:flutter/material.dart';

class startScreenSlider extends StatelessWidget {
  const startScreenSlider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _value = 20;
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      color: Color(0xff322f37),
      height: 80 / MediaQuery.of(context).devicePixelRatio,
      child: Row(
        children: [
          Flexible(
              flex: 3,
              fit: FlexFit.tight,
              child: Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text('Weight',
                      style:
                          TextStyle(fontSize: 17, color: Color(0xffeeeeee))))),
          Flexible(
              flex: 8,
              child: Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Container(
                      color: Colors.amber,
                      child: Slider(
                        min: 0.0,
                        max: 100.0,
                        value: _value,
                        onChanged: (value) {
                          //setState(() {
                          _value = value;
                          //});
                        },
                      ))))
        ],
      ),
    );
  }
}
