import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'dart:math';
import 'package:uke_mlab/models/screen_element_models/general_alarms.dart';
import 'package:uke_mlab/models/system_state.dart';
import 'package:uke_mlab/utilities/enums/non_graph_alarm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:uke_mlab/widgets/start_screen/aed_button.dart';
import 'package:uke_mlab/widgets/start_screen/patient_type_button.dart';
import 'package:uke_mlab/widgets/start_screen/continue_button.dart';
import 'package:uke_mlab/widgets/start_screen/details_popup.dart';
import 'package:uke_mlab/widgets/start_screen/skip_button.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // For general alarm testing purposes, TODO: Remove
    final GeneralAlarms generalAlarms = Get.find<SystemState>().generalAlarms;
    Timer.periodic(const Duration(seconds: 2), (timer) {
      if (Random().nextInt(10) > 1) {
        generalAlarms.addAlarm(
            nonGraphAlarmEnum
                .values[Random().nextInt(nonGraphAlarmEnum.values.length)],
            Random().nextInt(100));
      } else {
        if (generalAlarms.alarmList.isNotEmpty) {
          generalAlarms.removeAlarm(generalAlarms.alarmList[0].alarm);
        }
      }
    });

    Map<String, String> imageMap = {
      'Adult': 'assets/icons/adults2.svg',
      'Child': 'assets/icons/children.svg',
      'Infant': 'assets/icons/newborn.svg',
    };

    return SingleChildScrollView(
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: [
            Flexible(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children:
                    // TODO: precache images so loading doesn't take so long
                    // https://stackoverflow.com/questions/66872111/
                    imageMap.entries
                        .map((entry) => PatientTypeButton(
                              name: entry.key,
                              image: SvgPicture.asset(entry.value, height: 70),
                            ))
                        .toList(),
              ),
            ),
            Flexible(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const DetailsPopup(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Column(
                        children: const [
                          ContinueButton(),
                          SkipButton(),
                        ],
                      ),
                      const AEDButton(),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
