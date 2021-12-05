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
      style: ButtonStyle(
        shape: MaterialStateProperty.all(const RoundedRectangleBorder()),
        backgroundColor: MaterialStateProperty.all(Colors.green),
      ),
      onPressed: controller.selectedString.toString() != ""
          ? () {
              print("Pass selectedString to Monitor");
            }
          : null,
      child: const Text('Continue'),
    );
  }
}
