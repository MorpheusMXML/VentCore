import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/providers/toggle_controller.dart';

class ToggleThemeButton extends StatelessWidget {
  const ToggleThemeButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ToggleController toggleController = Get.find<ToggleController>();

    return IconButton(
      onPressed: () => toggleController.toggleTheme(),
      icon: Obx(() => toggleController.icon.value),
    );
  }
}
