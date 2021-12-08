// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';

class nameField extends StatelessWidget {
  const nameField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      height: 100 / MediaQuery.of(context).devicePixelRatio,
      color: const Color(0xff322f37),
      child: Row(
        children: const [
          Flexible(
            flex: 2,
            fit: FlexFit.tight,
            child: Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text('Name',
                  style: TextStyle(fontSize: 17, color: Color(0xffeeeeee))),
            ),
          ),
          Flexible(
              flex: 8,
              child: Padding(
                padding: EdgeInsets.only(right: 10),
                child: TextField(
                  cursorColor: Colors.black,
                  maxLines: 1,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      constraints: BoxConstraints(
                        maxHeight: 25,
                      ),
                      border: OutlineInputBorder(),
                      labelText: 'Patient Name',
                      labelStyle: TextStyle(color: Color(0xff8a8a8e))),
                ),
              ))
        ],
      ),
    );
  }
}
