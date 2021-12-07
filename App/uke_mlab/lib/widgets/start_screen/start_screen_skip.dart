import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StartScreenSkip extends StatelessWidget {
  const StartScreenSkip({
    Key? key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      margin: const EdgeInsets.fromLTRB(0, 0, 10, 12),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          fixedSize: const Size(200,60),
          primary: const Color(0xffeeeeee),
          onPrimary: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(75),
          ),
        ),
        child: const Text('Skip', style: TextStyle(fontSize: 20)),
        onPressed: () {
          Get.toNamed('/monitor', arguments: ["Adult"]);
        },
      ),
    );
  }
}
