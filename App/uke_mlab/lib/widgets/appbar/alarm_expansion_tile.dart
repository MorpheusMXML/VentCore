import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
    const double fSize = 25;

    // https://stackoverflow.com/questions/48895195/ align width

    return Obx(
      () {
        switch (systemState.generalAlarms.alarmList.length) {
          case 0:
            return Container();

          case 1:
            return Container(
              color: systemState.generalAlarms.alarmList[0].toColor(),
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 3,
                    child: Container(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        systemState.generalAlarms.alarmList[0].time.hour
                                .toString() +
                            ":" +
                            systemState.generalAlarms.alarmList[0].time.minute
                                .toString() +
                            ":" +
                            systemState.generalAlarms.alarmList[0].time.second
                                .toString(),
                        style: const TextStyle(
                          fontSize: fSize,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 9,
                    child: Center(
                      child: Text(
                        systemState.generalAlarms.alarmList[0].alarm.message,
                        style: const TextStyle(
                          fontSize: fSize,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    child: Container(),
                  ),
                ],
              ),
            );

          default:
            return Container(
              height: 50,
              color: systemState.generalAlarms.alarmList[0].toColor(),
              child: Center(
                child: DropdownButtonHideUnderline(
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
                              systemState.generalAlarms.alarmList[0].time.hour
                                      .toString() +
                                  ":" +
                                  systemState
                                      .generalAlarms.alarmList[0].time.minute
                                      .toString() +
                                  ":" +
                                  systemState
                                      .generalAlarms.alarmList[0].time.second
                                      .toString(),
                              style: const TextStyle(
                                fontSize: fSize,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 9,
                          child: Center(
                            child: Text(
                              systemState
                                  .generalAlarms.alarmList[0].alarm.message,
                              style: const TextStyle(
                                fontSize: fSize,
                                color: Colors.black,
                              ),
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
                    isDense: true,
                    onChanged: (value) {},
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
                                    value.time.hour.toString() +
                                        ":" +
                                        value.time.minute.toString() +
                                        ":" +
                                        value.time.second.toString(),
                                    style: const TextStyle(
                                      fontSize: fSize,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                              Flexible(
                                flex: 9,
                                child: Center(
                                  child: Text(
                                    value.alarm.message,
                                    style: const TextStyle(
                                      fontSize: fSize,
                                      color: Colors.black,
                                    ),
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
            );
        }
      },
    );
  }
}
