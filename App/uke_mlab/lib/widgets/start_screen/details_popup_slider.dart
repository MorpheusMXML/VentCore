import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/providers/start_screen_controller.dart';

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
    final startScreenController = Get.find<StartScreenController>();

    return Container(
      height: 100 / MediaQuery.of(context).devicePixelRatio,
      margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
      color: const Color(0xff322f37),
      child: Row(
        children: [
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
          Container(
            margin: const EdgeInsets.fromLTRB(0, 5, 10, 5),
            decoration: BoxDecoration(
                color: Theme.of(context).dividerColor,
                borderRadius: const BorderRadius.all(Radius.circular(3))),
            alignment: Alignment.center,
            height: 50 / MediaQuery.of(context).devicePixelRatio,
            width: 150 / MediaQuery.of(context).devicePixelRatio,
            child: Obx(
              () => Text(
                '${value.value.round().toString()}$unit',
                style: const TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
