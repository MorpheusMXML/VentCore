import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/providers/screen_controller.dart';
import 'package:uke_mlab/utilities/app_theme.dart';
import 'package:uke_mlab/utilities/enums/screen_status.dart';

/// Exit button for menus
///
/// Uses [ScreenController.menuExitButton] to lead back to previous screen denoted by [screenStatusEnum]
///
/// {@category DemoScreen}
class ExitButton extends StatelessWidget {
  const ExitButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Container(
      alignment: Alignment.centerRight,
      margin: const EdgeInsets.fromLTRB(0, 0, 50, 50),
      child: ElevatedButton(
        style: theme.navigationButtonStyle,
        child: Text(
          'Exit',
          style: theme.navigationButtonTextStyle,
        ),
        onPressed: () => Get.find<ScreenController>().menuExitButton(),
      ),
    );
  }
}
