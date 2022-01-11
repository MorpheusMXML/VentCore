import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:uke_mlab/models/general_alarms.dart';
import 'package:uke_mlab/models/system_state.dart';
import 'package:uke_mlab/utilities/enums/non_graph_alarm.dart';

class AlarmExpansionTile extends StatelessWidget {
  /// depending on amount of [GeneralAlarms] present in [SystemState], building either
  /// an empty field, a representation for said alarm or a dropdownmenu displaying all alarms to be used in [StatusBar]
  const AlarmExpansionTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemState systemState = Get.find<SystemState>();
    const TextStyle textStyle = TextStyle(
      color: Colors.black,
      fontSize: 25,
    );

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
                    hint: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          flex: 3,
                          child: Container(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              DateFormat.Hms().format(
                                  systemState.generalAlarms.alarmList[0].time),
                              style: textStyle,
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 9,
                          child: Center(
                            child: Text(
                              systemState
                                  .generalAlarms.alarmList[0].alarm.message,
                              style: textStyle,
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 2,
                          child: Container(),
                        ),
                      ],
                    ),
                    value: null,
                    onChanged: systemState.generalAlarms.alarmList.length == 1
                        ? null
                        : (value) {},
                    items: systemState.generalAlarms.alarmList
                        .map((AlarmListEntry value) {
                      return DropdownMenuItem(
                        enabled: false,
                        onTap: () {},
                        value: value,
                        child: Container(
                          margin: const EdgeInsets.only(top: 4),
                          color: value.toColor(),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                flex: 3,
                                child: Container(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(
                                    DateFormat.Hms().format(value.time),
                                    style: textStyle,
                                  ),
                                ),
                              ),
                              Flexible(
                                flex: 9,
                                child: Center(
                                  child: Text(
                                    value.alarm.message,
                                    style: textStyle,
                                  ),
                                ),
                              ),
                              Flexible(
                                flex: 2,
                                child: Container(),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
    );
  }
}
