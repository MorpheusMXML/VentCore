import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/providers/start_screen_controller.dart';
import 'package:uke_mlab/providers/screen_controller.dart';

/// This class contains the Continue Button and its functionality.
///
/// It provides a way to continue to the main screen with the previously selected patient preset and values.
class ContinueButton extends StatelessWidget {
  const ContinueButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final startScreenController = Get.find<StartScreenController>();
    final screenController = Get.find<ScreenController>();

    /// The returned Obx contains the behaviour and configuration of the Button
    return Obx(
      () => Container(
        alignment: Alignment.centerRight,
        margin: const EdgeInsets.fromLTRB(0, 0, 10, 12),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            fixedSize: const Size(200, 60),
            onSurface: const Color(0xffeeeeee),
            primary: const Color(0xffeeeeee),
            onPrimary: Colors.black,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(75)),
          ),
          onPressed: startScreenController.selectedString.value != ''
              ? () => screenController
                  .continueButton(startScreenController.selectedString.value)
              : null,

          /// The Child of the container holds the Text on the Button
          child: const Text('Continue',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}
