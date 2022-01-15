import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/models/general_alarms.dart';
import 'package:uke_mlab/models/system_state.dart';

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
        return Container(
          height: 50,
          margin: const EdgeInsets.only(left: 5),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: systemState.generalAlarms.alarmList[0].toColor(),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7))),
            onPressed: () => systemState.generalAlarms.listExpanded
                ? hideOverlay(context)
                : showOverlay(context),
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
          ),
        );
      },
    );
  }

  void showOverlay(BuildContext context) {
    GeneralAlarms generalAlarms = systemState.generalAlarms;
    generalAlarms.entry = OverlayEntry(
        builder: (context) =>
            Positioned(left: 100, top: 100, child: Text("ABC")));
    final overlay = Overlay.of(context)!;
    overlay.insert(generalAlarms.entry as OverlayEntry);
    generalAlarms.listExpanded = true;
  }

  void hideOverlay(BuildContext context) {
    GeneralAlarms generalAlarms = systemState.generalAlarms;
    generalAlarms.entry?.remove();
    generalAlarms.entry = null;
    generalAlarms.listExpanded = false;
  }
}
