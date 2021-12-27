import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/utilities/app_theme.dart';

class ToggleThemeButton extends StatelessWidget {
  const ToggleThemeButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // eventually use Switch widget here

    return ElevatedButton(
        onPressed: () {
          Get.isDarkMode
              ? Get.changeTheme(AppTheme.lightTheme)
              : Get.changeTheme(AppTheme.darkTheme);
        },
        child: const Text("Change Theme"));
  }
}
