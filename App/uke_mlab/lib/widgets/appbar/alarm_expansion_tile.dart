import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/models/general_alarms.dart';
import 'package:uke_mlab/models/system_state.dart';
import 'package:uke_mlab/widgets/appbar/alarm_expansion_entry.dart';

class AlarmExpansionTile extends StatelessWidget {
  /// depending on amount of [GeneralAlarms] present in [SystemState], building either
  /// an empty field, a representation for said alarm or a dropdownmenu displaying all alarms to be used in [StatusBar]
  const AlarmExpansionTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemState systemState = Get.find<SystemState>();

    return Obx(
      () => systemState.generalAlarms.alarmList.isEmpty
          ? Container()
          : Container(
              height: 50,
              color: systemState.generalAlarms.alarmList[0].toColor(),
              child: DropdownButtonHideUnderline(
                child: ButtonTheme(
                  alignedDropdown: true,
                  child: DropdownButton<dynamic>(
                    isExpanded: true,
                    hint: AlarmExpansionEntry(
                        data: systemState.generalAlarms.alarmList[0]),
                    value: null,
                    onChanged: systemState.generalAlarms.alarmList.length == 1
                        ? null
                        : (value) {},
                    items: systemState.generalAlarms.alarmList.map(
                      (AlarmListEntry value) {
                        return DropdownMenuItem(
                          enabled: false,
                          onTap: () {},
                          value: value,
                          child: Container(
                            margin: const EdgeInsets.only(top: 4),
                            color: value.toColor(),
                            child: AlarmExpansionEntry(data: value),
                          ),
                        );
                      },
                    ).toList(),
                  ),
                ),
              ),
            ),
    );
  }
}
