import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/providers/start_screen_controller.dart';
import 'package:uke_mlab/utilities/app_theme.dart';

/// Widget for StartScreen Buttons
/// [name] Buttontext
/// optional [image] SVG asset path
class PatientTypeButton extends StatelessWidget {
  final String name;
  final SvgPicture image;

  const PatientTypeButton({
    Key? key,
    required this.name,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final startScreenController = Get.find<StartScreenController>();

    return Container(
      margin: const EdgeInsets.fromLTRB(80, 0, 80, 10),
      child: Obx(
        () => ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: Size(800 / MediaQuery.of(context).devicePixelRatio,
                200 / MediaQuery.of(context).devicePixelRatio),
            primary: startScreenController.selectedString.value == name
                ? const Color(0xFF808B96)
                : const Color(0xFFEEEEEE),
            onPrimary: theme.inverseContrastColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(75)),
          ),

          ///get weight and height for chosen preset
          onPressed: () {
            startScreenController.settingsButton(name);
          },

          ///button content
          child: Row(
            children: [
              Flexible(
                flex: 2,
                //center svg within flexible
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    image,
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
                      style: const TextStyle(
                          fontSize: 35, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              //empty container in flexible to center text within in button (not best practice)
              Flexible(flex: 2, child: Container())
            ],
          ),
        ),
      ),
    );
  }
}
