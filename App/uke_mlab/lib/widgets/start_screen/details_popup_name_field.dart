import 'package:flutter/material.dart';

class PopupNameField extends StatelessWidget {
  const PopupNameField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      height: 100 / MediaQuery.of(context).devicePixelRatio,
      color: const Color(0xff322f37),
      child: Row(
        children: [
          const Flexible(
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
                padding: const EdgeInsets.only(right: 10),
                child: TextField(
                  style: const TextStyle(color: Colors.black),
                  cursorColor: Colors.black,
                  maxLines: 1,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Theme.of(context).dividerColor,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).dividerColor)),
                      constraints: const BoxConstraints(
                        maxHeight: 25,
                      ),
                      border: const OutlineInputBorder(),
                      labelText: 'Patient Name',
                      labelStyle: const TextStyle(color: Color(0xff8a8a8e))),
                ),
              ))
        ],
      ),
    );
  }
}
