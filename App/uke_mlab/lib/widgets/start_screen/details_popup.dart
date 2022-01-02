import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/providers/start_screen_controller.dart';
import 'package:uke_mlab/widgets/start_screen/details_popup_slider.dart';
import 'details_popup_name_field.dart';

class DetailsPopup extends StatelessWidget {
  const DetailsPopup({
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
                  const PopupNameField(),
                  PopupSlider(
                      name: 'Weight', unit: "kg", value: startScreenController.weightValue),
                  PopupSlider(
                      name: 'Height', unit: "cm", value: startScreenController.heightValue),
                ],
              ),
            )
          : Container(
              height: 400 / MediaQuery.of(context).devicePixelRatio,
              margin: const EdgeInsets.fromLTRB(0, 0, 65, 12),
            ),
    );
  }
}
