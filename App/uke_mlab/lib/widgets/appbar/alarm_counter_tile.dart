import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/models/screen_element_models/general_alarms.dart';
import 'package:uke_mlab/models/system_state.dart';
import 'package:uke_mlab/utilities/app_theme.dart';

/// Depending on the amount of [GeneralAlarms] builds an statusbar element displaying the amount, rendered in respective forms.
///
/// Allows to trigger an overlay containing all alarms.
class AlarmCounterTile extends StatelessWidget {
  AlarmCounterTile({Key? key}) : super(key: key);

  final GeneralAlarms generalAlarms = Get.find<SystemState>().generalAlarms;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Obx(
      () {
        String alarmText = generalAlarms.alarmList.length.toString();
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
            // TODO
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                  generalAlarms.alarmList[0].toColor()),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40))),
            ),
            onPressed: generalAlarms.alarmList.length <= 1
                ? null
                : () => generalAlarms.listExpanded.value
                    ? generalAlarms.hideOverlay()
                    : generalAlarms.showOverlay(context),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  alarmText,
                  textAlign: TextAlign.center,
                  style: theme.alarmTextStyle,
                ),
                generalAlarms.alarmList.length == 1
                    ? Container()
                    : generalAlarms.listExpanded.value
                        ? Icon(
                            Icons.arrow_drop_up,
                            color: theme.inverseContrastColor,
                            size: 50 * 0.6,
                          )
                        : Icon(
                            Icons.arrow_drop_down,
                            color: theme.inverseContrastColor,
                            size: 50 * 0.6,
                          ),
              ],
            ),
          ),
        );
      },
    );
  }
}
