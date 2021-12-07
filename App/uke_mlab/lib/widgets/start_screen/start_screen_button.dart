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
      return getButton(const Color(0xFF808B96), context, controller);
    } else {
      return getButton(const Color(0xFFEEEEEE), context, controller);
    }
  }

  getButton(
      Color color, BuildContext context, StartScreenController controller) {
    return Container(
      margin: const EdgeInsets.fromLTRB(65, 0, 0, 12),
      //Buttonstyle
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          fixedSize: Size(800 / MediaQuery.of(context).devicePixelRatio,
              155 / MediaQuery.of(context).devicePixelRatio),
          primary: color,
          onPrimary: Colors.black,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(75)),
        ),
        //get weight and height for chosen preset
        onPressed: () {
          controller.settingsButton(name);
        },
        //button content
        child: Row(
          children: [
            Flexible(
              flex: 2,
              //center svg within flexible
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    image,
                    height: 70,
                  ),
                ],
              ),
            ),
            Flexible(
              flex: 3,
              //center text within flexible
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    name,
                    style: const TextStyle(fontSize: 25),
                  ),
                ],
              ),
            ),
            //empty container in flexible to center text within in button (not best practice)
            Flexible(flex: 2, child: Container())
          ],
        ),
      ),
    );
  }
}
