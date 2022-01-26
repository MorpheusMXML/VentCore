import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/providers/start_screen_controller.dart';
import 'package:uke_mlab/utilities/app_theme.dart';
import 'package:uke_mlab/widgets/start_screen/details_popup_slider.dart';

/// This class contains the Details Popup and its functionality.
/// {@category Widgets}
/// {@subCategory Start Screen}
class DetailsPopup extends StatelessWidget {
  const DetailsPopup({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final startScreenController = Get.find<StartScreenController>();

    /// The Obx contains the functionality of the Widget.
    return Obx(
      () => startScreenController.isPopupVisible.value
          ? Container(
              margin: const EdgeInsets.only(right: 65, bottom: 12),
              color: theme.primarySwatch[50],
              ///The Column contains the Popup Sliders and provides their names and units.
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
