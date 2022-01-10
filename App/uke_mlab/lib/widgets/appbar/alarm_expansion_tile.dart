import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/models/general_alarms.dart';
import 'package:uke_mlab/models/system_state.dart';
import 'package:uke_mlab/utilities/enums/non_graph_alarm.dart';

class AlarmExpansionTile extends StatelessWidget {
  const AlarmExpansionTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemState systemState = Get.find<SystemState>();

    // https://stackoverflow.com/questions/48895195/ align width

    return Obx(
      () {
        switch (systemState.generalAlarms.alarmList.length) {
          case 0:
            return Container();

          case 1:
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(systemState.generalAlarms.alarmList[0].alarm.message),
                const Text('1'),
              ],
            );

          default:
            return Container(
              height: 50,
              color: systemState.generalAlarms.alarmList[0].toColor(),
              child: Center(
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<dynamic>(
                    isExpanded: true,
                    hint: Center(
                      child: Text(
                        systemState.generalAlarms.alarmList[0].alarm.message,
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
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
                          child: Center(
                            child: Text(
                              value.alarm.message,
                              style: const TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                              ),
                            ),
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
