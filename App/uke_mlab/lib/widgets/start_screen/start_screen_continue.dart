import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/models/enums.dart';
import 'package:uke_mlab/models/model_manager.dart';
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
    return Obx(
      () => Container(
        alignment: Alignment.centerRight,
        margin: const EdgeInsets.fromLTRB(0, 0, 10, 12),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            fixedSize: const Size(200, 60),
            onSurface: const Color(0xffeeeeee),
            primary: const Color(0xffeeeeee),
            onPrimary: Colors.black,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(75)),
          ),
          onPressed: controller.selectedString.toString() != ""
              ? () {
                  final ModelManager modelManager = Get.find<ModelManager>();
                  if (controller.selectedString.value == "Adult") {
                    modelManager.loadPatientPresets(patientTypeEnum.adult);
                  } else if (controller.selectedString.value == "Child") {
                    modelManager.loadPatientPresets(patientTypeEnum.child);
                  } else if (controller.selectedString.value == "Infant") {
                    modelManager.loadPatientPresets(patientTypeEnum.infant);
                  }
                  Get.toNamed('/monitor',
                      arguments: [controller.selectedString.value]);
                }
              : null,
          child: const Text('Continue', style: TextStyle(fontSize: 20)),
        ),
      ),
    );
  }
}
