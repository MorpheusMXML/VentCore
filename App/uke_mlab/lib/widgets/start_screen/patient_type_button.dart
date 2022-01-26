import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/providers/start_screen_controller.dart';
import 'package:uke_mlab/utilities/app_theme.dart';

/// This class contains the configurations for the StartScreen Buttons for the patient presets.
///
/// ### Variables
/// + [name] is an instance of a [String] which will be displayed on a button.
/// + [image] is an instance of a [String] which points to a .svg in the assets of the app.
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
                ? theme.primarySwatch[20]
                : theme.primarySwatch[10],
            onPrimary: theme.inverseContrastColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(75)),
          ),

          ///get weight and height for chosen preset
          onPressed: () {
            startScreenController.settingsButton(name);
          },

          ///The Row contains the elements of the Button in Flexibles to help with positioning.
          child: Row(
            children: [
              ///The first Flexible contains the image.
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

              ///The second Flexible contains the name of the button.
              Flexible(
                flex: 3,
                //center text within flexible
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      name,
                      style: theme.patientTypeTextStyle,
                    ),
                  ],
                ),
              ),

              ///The last Flexible contains an empty container to help center the name.
              Flexible(flex: 2, child: Container())
            ],
          ),
        ),
      ),
    );
  }
}
