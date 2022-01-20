import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/models/system_state.dart';

class ToggleThemeButton extends StatelessWidget {
  const ToggleThemeButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemState systemState = Get.find<SystemState>();

    return IconButton(
      onPressed: () => systemState.themeModel.toggleTheme(),
      icon: Obx(() => systemState.themeModel.toggleIcon.value),
    );
  }
}
