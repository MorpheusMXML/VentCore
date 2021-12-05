import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/providers/start_screen_controller.dart';

//Widget for StartScreen Buttons
//@param name Buttontext
//@param optional image SVG asset path

class StartScreenButton extends StatelessWidget {
  final String name;
  final String image;

  const StartScreenButton({
    Key? key,
    required this.name,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StartScreenController>(
        init: StartScreenController(),
        builder: (controller) => getWidget(controller, context));
  }

  getWidget(StartScreenController controller, BuildContext context) {
    if (controller.selectedString.toString() == name) {
      return getButton(Colors.blue, context, controller);
    } else {
      return getButton(const Color(0xFFEEEEEE), context, controller);
    }
  }

  getButton(
      Color color, BuildContext context, StartScreenController controller) {
    return Container(
      margin: const EdgeInsets.fromLTRB(65, 0, 0, 12),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          fixedSize: Size(800 / MediaQuery.of(context).devicePixelRatio,
              155 / MediaQuery.of(context).devicePixelRatio),
          primary: color,
          onPrimary: Colors.black,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(75)),
        ),
        onPressed: () {
          controller.settingsButton(name);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              image,
              height: 70.0,
            ),
            Text(
              name,
              style: const TextStyle(fontSize: 25),
            ),
          ],
        ),
      ),
    );
  }
}
