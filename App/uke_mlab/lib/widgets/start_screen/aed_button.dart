// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'package:uke_mlab/models/enums.dart';
import 'package:uke_mlab/utilities/screen_controller.dart';

class aedButton extends StatelessWidget {
  const aedButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenController = Get.find<ScreenController>();

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
            Get.offNamed(
              screenController.changeScreen1(screenChangeButtonEnum.aedButton),
              arguments: {"patientType": "Adult"},
            );
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
