import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/models/system_state.dart';
import 'package:uke_mlab/utilities/enums/non_graph_alarm.dart';
import 'package:intl/intl.dart';

class StatusBar extends StatelessWidget {
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
          child: Obx(() =>
              alarmExpensionTile(systemState.generalAlarms.alarmList.length)),
        ),
        /*
        Flexible(
          flex: 5,
          child: Obx(
            () => Text(
              systemState.alarmMessage.value,
              style: TextStyle(
                color: systemState.alarmMessage.value == ''
                    ? Theme.of(context).dividerColor
                    : Colors.red,
                decoration: TextDecoration.none,
              ),
            ),
          ),
        ),*/
        Flexible(
          flex: 1,
          child: Text(
            systemState.patientType.toString() == 'patientTypeEnum.none'
                ? ''
                : systemState.patientType.name,
            style: TextStyle(
              color: Theme.of(context).dividerColor,
              decoration: TextDecoration.none,
            ),
          ),
        ),
        Flexible(
          flex: 1,
          child: Text(
            DateFormat.Hm().format(DateTime.now()),
            style: TextStyle(
              color: Theme.of(context).dividerColor,
              decoration: TextDecoration.none,
            ),
          ),
        ),
        Flexible(
          flex: 1,
          child: SvgPicture.asset('assets/icons/OxygenBottle.svg', height: 20),
        )
      ],
    );
  }

  Widget alarmExpensionTile(int listLength) {
    SystemState systemState = Get.find<SystemState>();

    if (listLength == 0) {
      return ConstrainedBox(constraints: const BoxConstraints(minWidth: 700));
    } else if (listLength == 1) {
      return ConstrainedBox(
        constraints: const BoxConstraints(minWidth: 700, minHeight: 50),
        child: Container(
          padding: const EdgeInsets.only(right: 35),
          color: Colors.blue, //TODO set color
          child: Center(
            child: Text(
              systemState.generalAlarms.alarmList[0].alarm.message,
              style: const TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
    } else {
      return ConstrainedBox(
        constraints: const BoxConstraints(minWidth: 700, minHeight: 50),
        child: Container(
          color: Colors.red, //TODO set corresponding color
          child: Center(
            child: Text(
              systemState.generalAlarms.alarmList[0].alarm.message,
              style: const TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
          ),
          //TODO add expansion possibility
        ),
      );
    }
  }
}
