import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/models/system_state.dart';

class AlarmCounterTile extends StatelessWidget {
  /// Builds depending on the amount of [GeneralAlarms] an statusbar element displaying the amount, rendered in respective forms.
  /// Could be combined with the [AlarmExpansionTile] due to similar code functionality, but extracted to make placing in [StatusBar] easier
  const AlarmCounterTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemState systemState = Get.find<SystemState>();
    const double fSize = 25;
    String alarmText = systemState.generalAlarms.alarmList.length.toString();

    return Obx(
      () {
        switch (systemState.generalAlarms.alarmList.length) {
          case 0:
            return Container();
          case 1:
            alarmText = alarmText + " general Alarm";
            break;
          default:
            alarmText = alarmText + " general Alarms";
        }
        return Container(
          height: 50,
          margin: const EdgeInsets.only(left: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7),
            color: systemState.generalAlarms.alarmList[0].toColor(),
          ),
          child: Center(
            child: Text(
              alarmText,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black,
                fontSize: fSize,
              ),
            ),
          ),
        );
      },
    );
  }
}
