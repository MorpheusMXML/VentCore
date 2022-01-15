import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/models/system_state.dart';
import 'package:uke_mlab/widgets/appbar/alarm_expansion_entry.dart';
import 'package:uke_mlab/utilities/enums/patient_type.dart';
import 'alarm_counter_tile.dart';

class StatusBar extends StatelessWidget {
  /// constructs the status bar for usage over the whole project
  const StatusBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final systemState = Get.find<SystemState>();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          flex: 5,
          fit: FlexFit.loose,
          child: Row(
            children: [
              //DropDown Menu (AlarmExpansionTile)
              Flexible(
                flex: 7,
                fit: FlexFit.tight,
                child: Obx(() => systemState.generalAlarms.alarmList.isEmpty
                    ? Container()
                    : AlarmExpansionEntry(
                        data: systemState.generalAlarms.alarmList[0])),
              ),
              //Info about Alarm amount (AlarmCounterTile)
              Flexible(
                flex: 2,
                fit: FlexFit.loose,
                child: AlarmCounterTile(),
              ),
            ],
          ),
        ),
        // PatientType display
        Flexible(
          flex: 1,
          child: Text(
            // TODO: reset this value after scenario ends?
            systemState.patientType.displayString,
            style: TextStyle(
              color: Theme.of(context).dividerColor,
              decoration: TextDecoration.none,
            ),
          ),
        ),
        // O2 bottly display
        Flexible(
          flex: 1,
          child: Center(
              child: SvgPicture.asset('assets/icons/OxygenBottle.svg',
                  height: 20)),
        ),
      ],
    );
  }
}
