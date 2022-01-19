import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/models/screen_element_models/general_alarms.dart';
import 'package:uke_mlab/models/system_state.dart';
import 'package:uke_mlab/utilities/constants/statusbar_constants.dart';
import 'package:uke_mlab/widgets/appbar/alarm_list.dart';

class AlarmCounterTile extends StatelessWidget {
  /// Builds depending on the amount of [GeneralAlarms] an statusbar element displaying the amount, rendered in respective forms.
  /// Could be combined with the [AlarmExpansionTile] due to similar code functionality, but extracted to make placing in [StatusBar] easier
  AlarmCounterTile({Key? key}) : super(key: key);

  final SystemState systemState = Get.find<SystemState>();

  @override
  Widget build(BuildContext context) {
    const double fSize = 24;

    return Obx(
      () {
        String alarmText =
            systemState.generalAlarms.alarmList.length.toString();
        switch (systemState.generalAlarms.alarmList.length) {
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
                  systemState.generalAlarms.alarmList[0].toColor()),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40))),
            ),
            onPressed: systemState.generalAlarms.alarmList.length <= 1
                ? null
                : () => {
                      systemState.generalAlarms.listExpanded.value
                          ? {hideOverlay(context)}
                          : {showOverlay(context)}
                    },
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
                systemState.generalAlarms.alarmList.length == 1
                    ? Container()
                    : systemState.generalAlarms.listExpanded.value
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

  void showOverlay(BuildContext context) {
    GeneralAlarms generalAlarms = systemState.generalAlarms;
    double statusBarHeight = MediaQuery.of(context).padding.top;

    generalAlarms.entry = OverlayEntry(
      builder: (context) => Positioned(
        left: StatusBarConstants.menuButtonWidth,
        top: statusBarHeight,
        child: const AlarmList(),
      ),
    );
    final overlay = Overlay.of(context)!;
    overlay.insert(generalAlarms.entry as OverlayEntry);
    generalAlarms.listExpanded.value = true;
  }

  void hideOverlay(BuildContext context) {
    GeneralAlarms generalAlarms = systemState.generalAlarms;
    generalAlarms.entry?.remove();
    generalAlarms.entry = null;
    generalAlarms.listExpanded.value = false;
  }
}
