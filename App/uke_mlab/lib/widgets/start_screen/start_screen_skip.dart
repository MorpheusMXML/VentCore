import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/models/enums.dart';
import 'package:uke_mlab/models/model_manager.dart';
import 'package:uke_mlab/models/system_state.dart';
import 'package:uke_mlab/providers/start_screen_controller.dart';
import 'package:uke_mlab/utilities/screen_controller.dart';

class StartScreenSkip extends StatelessWidget {
  const StartScreenSkip({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final startScreenController = Get.find<StartScreenController>();
    final screenController = Get.find<ScreenController>();

    return Container(
      alignment: Alignment.centerRight,
      margin: const EdgeInsets.fromLTRB(0, 0, 10, 12),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          fixedSize: const Size(200, 60),
          primary: const Color(0xffeeeeee),
          onPrimary: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(75),
          ),
        ),
        child: const Text('Skip', style: TextStyle(fontSize: 20)),
        onPressed: () {
          Get.offNamed(
            screenController.changeScreen1(screenChangeButtonEnum.aedButton),
          );
          startScreenController.selectedString.value = "Adult";
        },
      ),
    );
  }
}
