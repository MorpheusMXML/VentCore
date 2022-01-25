import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/providers/start_screen_controller.dart';
import 'package:uke_mlab/providers/screen_controller.dart';
import 'package:uke_mlab/utilities/app_theme.dart';

// TODO: COMMENTARY
class ContinueButton extends StatelessWidget {
  const ContinueButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final startScreenController = Get.find<StartScreenController>();
    final screenController = Get.find<ScreenController>();

    return Obx(
      () => Container(
        alignment: Alignment.centerRight,
        margin: const EdgeInsets.fromLTRB(0, 0, 10, 12),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            fixedSize: const Size(200, 60),
            onSurface: const Color(0xffeeeeee),
            primary: const Color(0xffeeeeee),
            onPrimary: theme.inverseContrastColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(75)),
          ),
          onPressed: startScreenController.selectedString.value != ''
              ? () => screenController
                  .continueButton(startScreenController.selectedString.value)
              : null,
          child: const Text('Continue',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}
