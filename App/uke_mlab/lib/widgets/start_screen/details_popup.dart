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
              margin: const EdgeInsets.only(right: 65, bottom: 12),
              color: Theme.of(context).focusColor,
              child: Column(
                children: [
                  PopupSlider(name: 'Weight', unit: 'kg', value: startScreenController.weightValue),
                  PopupSlider(name: 'Height', unit: 'cm', value: startScreenController.heightValue),
                ],
              ),
            )
          : Container(),
    );
  }
}
