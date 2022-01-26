import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/providers/start_screen_controller.dart';
import 'package:uke_mlab/providers/screen_controller.dart';
import 'package:uke_mlab/utilities/app_theme.dart';

/// This class contains the Continue Button and its functionality.
///
/// It provides a way to continue to the main screen with the previously selected patient preset and values.
class ContinueButton extends StatelessWidget {
  const ContinueButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final startScreenController = Get.find<StartScreenController>();
    final screenController = Get.find<ScreenController>();

    /// The returned Obx contains the behaviour and configuration of the Button
    return Obx(
      () => Container(
        alignment: Alignment.centerRight,
        margin: const EdgeInsets.fromLTRB(0, 0, 10, 12),
        child: ElevatedButton(
          style: theme.navigationButtonStyle,
          onPressed: startScreenController.selectedString.value != ''
              ? () => screenController
                  .continueButton(startScreenController.selectedString.value)
              : null,

          /// The Child of the container holds the Text on the Button
          child: Text(
            'Continue',
            style: theme.navigationButtonTextStyle,
          ),
        ),
      ),
    );
  }
}
