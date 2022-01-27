import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/providers/screen_controller.dart';
import 'package:uke_mlab/utilities/app_theme.dart';

/// This class contains the [SkipButton] and its functionality.
///
/// It provides a way to continue to the main screen without selecting patient preset and values.
/// Instead it just continues to the main screen with default values.
///
/// {@category StartScreen}
class SkipButton extends StatelessWidget {
  const SkipButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final screenController = Get.find<ScreenController>();

    /// The Container contains the Buttons configuration and functionality.
    return Container(
      alignment: Alignment.centerRight,
      margin: const EdgeInsets.fromLTRB(0, 0, 10, 12),
      child: ElevatedButton(
        style: theme.navigationButtonStyle,
        child: Text('Skip', style: theme.navigationButtonTextStyle),
        onPressed: () => screenController.skipButton(),
      ),
    );
  }
}
