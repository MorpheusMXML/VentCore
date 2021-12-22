import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/providers/mockup.dart';

class SettingText extends StatelessWidget {
  final String name;
  final String rate;
  const SettingText({Key? key, required this.name, required this.rate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final monitorController = Get.find<MonitorController>();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.baseline, //gets text in same line
      textBaseline: TextBaseline.ideographic, //gets text in same line
      children: [
        Text(
          name,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
        Obx(
          () => Text(
            monitorController.ippvValues[name].toString(),
            style: const TextStyle(
              fontSize: 32,
              color: Colors.white,
            ),
          ),
        ),
        Text(rate, style: const TextStyle(fontSize: 12, color: Colors.white)),
      ],
    );
  }
}
