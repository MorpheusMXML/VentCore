import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/utilities/app_theme.dart';
import 'package:uke_mlab/widgets/menu/toggle_theme_button.dart';

/// Contains information about the current active [AppTheme].
///
/// {@category ScreenElementModels}
class ThemeModel {
  /// the icon representing the current [AppTheme] on the [ToggleThemeButton]
  Rx<Icon> toggleIcon = const Icon(Icons.dark_mode).obs;

  /// Toggles the current [AppTheme] from light to dark mode.
  void toggleTheme() {
    if (Get.isDarkMode) {
      Get.changeTheme(AppTheme.lightTheme);
      toggleIcon.value = const Icon(Icons.light_mode_rounded);
    } else {
      Get.changeTheme(AppTheme.darkTheme);
      toggleIcon.value = const Icon(Icons.dark_mode_rounded);
    }
  }
}
