// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'package:uke_mlab/models/model_manager.dart';
import 'package:uke_mlab/models/system_state.dart';
import 'package:uke_mlab/models/enums.dart';

import 'package:uke_mlab/utilities/screen_controller.dart';

class aedButton extends StatelessWidget {
  const aedButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      margin: const EdgeInsets.fromLTRB(0, 0, 65, 12),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            fixedSize: Size(300 / MediaQuery.of(context).devicePixelRatio,
                300 / MediaQuery.of(context).devicePixelRatio),
            primary: const Color(0xff363638),
            onPrimary: const Color(0xff34c759),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          ),
          onPressed: () {
            //If aed is pressed + no prior patient type selected => load adult presets (could be confusing, subject to change?)
            Get.find<ScreenController>()
                .changeScreen1(screenChangeButtonEnum.aedButton);
            Get.toNamed('/monitor', arguments: ["Adult"]);
          },
          child: Column(
            children: [
              SvgPicture.asset(
                'assets/icons/AED2.svg', //smaller than AED.svg
                height: 250 /
                    MediaQuery.of(context)
                        .devicePixelRatio, //responsive for different Screens
                color: const Color(0xff34c759),
              ),
              const Text('AED')
            ],
          )),
    );
  }
}
