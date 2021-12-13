import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/providers/start_screen_controller.dart';
import 'package:uke_mlab/widgets/start_screen/slider_tile.dart';
import 'name_field.dart';

class StartScreenPopup extends StatelessWidget {
  const StartScreenPopup({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final startScreenController = Get.find<StartScreenController>();

    return Obx(
      () => startScreenController.isPopupVisible.value
          ? Container(
              margin: const EdgeInsets.fromLTRB(0, 22, 65, 12),
              color: const Color(0xff25232a),
              child: Column(
                children: [
                  const nameField(),
                  SliderTile(
                      name: "Weight", value: startScreenController.weightValue),
                  SliderTile(
                      name: "Height", value: startScreenController.heightValue),
                ],
              ),
            )
          : Container(
              height: 188,
              margin: const EdgeInsets.fromLTRB(0, 0, 65, 12),
            ),
    );
  }
}
