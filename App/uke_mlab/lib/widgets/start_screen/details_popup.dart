import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/providers/start_screen_controller.dart';
import 'package:uke_mlab/utilities/app_theme.dart';
import 'package:uke_mlab/widgets/start_screen/details_popup_slider.dart';

// TODO: COMMENTARY
class DetailsPopup extends StatelessWidget {
  const DetailsPopup({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final startScreenController = Get.find<StartScreenController>();

    return Obx(
      () => startScreenController.isPopupVisible.value
          ? Container(
              margin: const EdgeInsets.only(right: 65, bottom: 12),
              color: theme.primarySwatch[50],
              child: Column(
                children: [
                  PopupSlider(
                      name: 'Weight',
                      unit: 'kg',
                      value: startScreenController.weightValue),
                  PopupSlider(
                      name: 'Height',
                      unit: 'cm',
                      value: startScreenController.heightValue),
                ],
              ),
            )
          : Container(),
    );
  }
}
