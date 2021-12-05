import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/providers/mockup.dart';

class SettingText extends StatelessWidget {
  final MonitorController controller;
  final String name;
  final String rate;
  const SettingText(
      {Key? key,
      required this.controller,
      required this.name,
      required this.rate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text(
        name,
        style: const TextStyle(fontSize: 16, color: Colors.white),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Obx(
            () => Text(controller.ippvFreq.value.toString(),
                style: const TextStyle(fontSize: 32, color: Colors.white)),
          ),
          Text(rate, style: const TextStyle(fontSize: 16, color: Colors.white)),
        ],
      )
    ]);
  }
}
