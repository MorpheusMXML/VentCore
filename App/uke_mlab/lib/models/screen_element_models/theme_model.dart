import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/utilities/app_theme.dart';

class ThemeModel {
  RxBool isDarkMode = true.obs;

  Rx<Icon> toggleIcon = const Icon(Icons.dark_mode).obs;

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
