import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/providers/screen_controller.dart';

class ExitButton extends StatelessWidget {
  const ExitButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      margin: const EdgeInsets.fromLTRB(0, 0, 50, 50),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          fixedSize: const Size(200, 60),
          primary: const Color(0xFFEEEEEE),
          onPrimary: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(75),
          ),
        ),
        child: const Text('Exit', style: TextStyle(fontSize: 20)),
        onPressed: () =>
            Get.find<ScreenController>().scenarioMenuExitButton(),
      ),
    );
  }
}
