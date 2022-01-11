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
    return Obx(
      () {
        switch (systemState.generalAlarms.alarmList.length) {
          case 0:
            return Container();
          case 1:
            return Container(
              height: 50,
              margin: const EdgeInsets.only(left: 5),
              color: systemState.generalAlarms.alarmList[0].toColor(),
              child: Center(
                child: Text(
                  '${systemState.generalAlarms.alarmList.length} general Alarm',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: fSize,
                  ),
                ),
              ),
            );
          default:
            return Container(
              height: 50,
              margin: const EdgeInsets.only(left: 5),
              color: systemState.generalAlarms.alarmList[0].toColor(),
              child: Center(
                child: Text(
                  '${systemState.generalAlarms.alarmList.length} general Alarms',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: fSize,
                  ),
                ),
              ),
            );
        }
      },
    );
  }
}
