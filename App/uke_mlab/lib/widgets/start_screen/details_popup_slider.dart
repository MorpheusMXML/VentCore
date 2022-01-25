import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/providers/start_screen_controller.dart';
import 'package:uke_mlab/utilities/app_theme.dart';

/// This class contains the Popup Slider and its [Slider] functionality.
/// 
/// ### Class Variables
/// + [name] holds an instance of [String] which will be used as the displayed Name for this widget.
/// + [unit] holds an instance of [String] which will be used as the displayed unit for this widget.
/// + [value] holds an instance of [RxDouble] which will be used as the displayed value for this widget.
class PopupSlider extends StatelessWidget {
  final String name;
  final String unit;
  final RxDouble value;

  const PopupSlider({
    Key? key,
    required this.name,
    required this.unit,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final startScreenController = Get.find<StartScreenController>();
    ///
    return Container(
      height: 100 / MediaQuery.of(context).devicePixelRatio,
      margin: const EdgeInsets.fromLTRB(12, 12, 12, 12),
      color: const Color(0xff322f37),
      /// The Flexibles contain the layout of the objects in the Container
      child: Row(
        children: [
          /// This Flexible contains the name of the Slider.
          Flexible(
            flex: 2,
            fit: FlexFit.tight,
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                name,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xffeeeeee),
                ),
              ),
            ),
          ),
          /// This Flexible contains the Slider functionality, size and gets the value.
          Flexible(
            flex: 8,
            child: Obx(
              () => Slider(
                  min: 0.0,
                  max: 250.0,
                  divisions: 25,
                  value: value.value,
                  label: value.value.round().toString(),
                  onChanged: (newValue) {
                    startScreenController.setValue(newValue, name);
                  }),
            ),
          ),
          /// This Container contains the displayed value with the unit added.
          Container(
            margin: const EdgeInsets.fromLTRB(0, 5, 10, 5),
            decoration: BoxDecoration(
                color: theme.contrastColor,
                borderRadius: const BorderRadius.all(Radius.circular(3))),
            alignment: Alignment.center,
            height: 50 / MediaQuery.of(context).devicePixelRatio,
            width: 150 / MediaQuery.of(context).devicePixelRatio,
            child: Obx(
              () => Text(
                '${value.value.round().toString()}$unit',
                style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                    color: theme.inverseContrastColor),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
