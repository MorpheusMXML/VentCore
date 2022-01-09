import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/models/system_state.dart';
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
        ),
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
          child: SvgPicture.asset('assets/icons/OxygenBottle.svg', height: 20),
        )
      ],
    );
  }
}
