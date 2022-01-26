import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/providers/screen_controller.dart';

/// This class contains the Skip Button and its functionality.
///
/// It provides a way to continue to the main screen without selecting patient preset and values.
/// Instead it just continues to the main screen with default values.
class SkipButton extends StatelessWidget {
  const SkipButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenController = Get.find<ScreenController>();

    /// The Container contains the Buttons configuration and functionality.
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
        child: const Text('Skip',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
        onPressed: () => screenController.skipButton(),
      ),
    );
  }
}
