import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/utilities/app_theme.dart';
import 'package:uke_mlab/widgets/menu/toggle_theme_button.dart';

class ThemeModel {
  /// contains information about the current active [AppTheme]

  /// flag whether dark mode is currently active, starts at true
  RxBool isDarkMode = true.obs;

  /// the icon representing the current [AppTheme] on the [ToggleThemeButton]
  Rx<Icon> toggleIcon = const Icon(Icons.dark_mode).obs;

  /// toggles the current [AppTheme] from light to dark mode
  void toggleTheme() {
    if (isDarkMode.value) {
      Get.changeTheme(AppTheme.lightTheme);
      isDarkMode.toggle();
      toggleIcon.value = const Icon(Icons.light_mode_rounded);
    } else {
      Get.changeTheme(AppTheme.darkTheme);
      isDarkMode.toggle();
      toggleIcon.value = const Icon(Icons.dark_mode_rounded);
    }
  }
}
