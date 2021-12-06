import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/providers/start_screen_controller.dart';

class StartScreenContinue extends StatelessWidget {
  const StartScreenContinue({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StartScreenController>(
        init: StartScreenController(),
        builder: (controller) => getWidget(controller));
  }

  getWidget(controller) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 0, 65, 12),
      child: Obx(
        () => ElevatedButton(
          style: ElevatedButton.styleFrom(
            onSurface: const Color(0xffeeeeee),
            primary: const Color(0xffeeeeee),
            onPrimary: Colors.black,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(75)),
          ),
          onPressed: controller.selectedString.toString() != ""
              ? () {
                  Get.toNamed('/monitor',
                      arguments: [controller.selectedString]);
                }
              : null,
          child: const Text('Continue', style: TextStyle(fontSize: 20)),
        ),
      ),
    );
  }
}
