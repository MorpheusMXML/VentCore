import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/models/general_alarms.dart';

class AlarmCounterTile extends StatelessWidget {
  /// Builds depending on the amount of [GeneralAlarms] an statusbar element displaying the amount, rendered in respective forms.
  /// Could be combined with the [AlarmExpansionTile] due to similar code functionality, but extracted to make placing in [StatusBar] easier
  AlarmCounterTile({Key? key}) : super(key: key);

  final GeneralAlarms generalAlarms = Get.find<GeneralAlarms>();

  @override
  Widget build(BuildContext context) {
    const double fSize = 24;

    return Obx(
      () {
        String alarmText =
            generalAlarms.alarmList.length.toString();
        switch (generalAlarms.alarmList.length) {
          case 0:
            return Container();
          case 1:
            alarmText = alarmText + " sys. Alarm";
            break;
          default:
            alarmText = alarmText + " sys. Alarms";
        }
        return SizedBox(
          height: 50,
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                  generalAlarms.alarmList[0].toColor()),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40))),
            ),
            onPressed: generalAlarms.alarmList.length <= 1
                ? null
                : () => generalAlarms.listExpanded.value
                    ? generalAlarms.hideOverlay(context)
                    : generalAlarms.showOverlay(context),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  alarmText,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: fSize,
                  ),
                ),
                generalAlarms.alarmList.length == 1
                    ? Container()
                    : generalAlarms.listExpanded.value
                        ? const Icon(
                            Icons.arrow_upward_rounded,
                            color: Colors.black,
                            size: 40,
                          )
                        : const Icon(
                            Icons.arrow_downward_rounded,
                            color: Colors.black,
                            size: 40,
                          ),
              ],
            ),
          ),
        );
      },
    );
  }
}
