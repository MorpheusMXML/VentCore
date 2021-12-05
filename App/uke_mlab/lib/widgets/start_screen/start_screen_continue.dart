import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/providers/start_screen_controller.dart';

class StartScreenContinue extends StatelessWidget {
  const StartScreenContinue({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StartScreenController>(
        init: StartScreenController(),
        builder: (controller) => getWidget(controller));
  }

  getWidget(controller) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        onSurface: const Color(0xffeeeeee),
        primary: const Color(0xffeeeeee),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(75)),
      ),
      onPressed: controller.selectedString.toString() != ""
          ? () {
              print("Pass selectedString to Monitor");
            }
          : null,
      child: const Text(
        'Continue',
        style: TextStyle(color: Colors.black),
      ),
    );
  }
}
