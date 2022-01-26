import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'package:uke_mlab/providers/screen_controller.dart';
import 'package:uke_mlab/utilities/app_theme.dart';

/// This class contains the AED Button and provides its functionality.
/// {@category Widgets}
/// {@subCategory Start Screen}
class AEDButton extends StatelessWidget {
  const AEDButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ScreenController screenController = Get.find<ScreenController>();

    ///The Container contains the configuration of the Button and its behaviour.
    return Container(
      alignment: Alignment.centerRight,
      margin: const EdgeInsets.fromLTRB(0, 0, 65, 12),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            fixedSize: Size(300 / MediaQuery.of(context).devicePixelRatio,
                300 / MediaQuery.of(context).devicePixelRatio),
            primary: theme.primarySwatch[25],
            onPrimary: AppTheme.alarmWarningColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          ),
          onPressed: () => screenController.aedButton(),

          ///The Column contains the layout of the AED Button.
          child: Column(
            children: [
              SvgPicture.asset(
                'assets/icons/AED2.svg', //smaller than AED.svg
                height: 250 / MediaQuery.of(context).devicePixelRatio,
                color: AppTheme.alarmWarningColor,
              ),
              Text(
                'AED',
                style: theme.aedButtonTextStyle,
              )
            ],
          )),
    );
  }
}
