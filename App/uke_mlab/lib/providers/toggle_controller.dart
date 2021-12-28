import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/utilities/app_theme.dart';

class ToggleBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ToggleController());
  }
}

class ToggleController extends GetxController {
  RxList<bool> isSelected = [true, false, false].obs;

  void setSelected(int index) {
    for (var i = 0; i <= isSelected.length - 1; i++) {
      index == i ? isSelected[i] = true : isSelected[i] = false;
    }
  }

  RxBool isDarkMode = true.obs;
  Rx<Icon> icon = const Icon(Icons.dark_mode).obs;

  void toggleTheme() {
    if (isDarkMode.value) {
      Get.changeTheme(AppTheme.lightTheme);
      isDarkMode.toggle();
      icon.value = const Icon(Icons.light_mode_rounded);
    } else {
      Get.changeTheme(AppTheme.darkTheme);
      isDarkMode.toggle();
      icon.value = const Icon(Icons.dark_mode_rounded);
    }
  }
}
