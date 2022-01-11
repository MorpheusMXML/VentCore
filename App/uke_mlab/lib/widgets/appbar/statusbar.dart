import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/models/system_state.dart';
import 'package:intl/intl.dart';
import 'package:uke_mlab/widgets/appbar/alarm_expansion_tile.dart';

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
            flex: 7,
            fit: FlexFit.loose,
            child: Row(
              children: const [
                Flexible(
                  flex: 5,
                  fit: FlexFit.tight,
                  child: AlarmExpansionTile(),
                ),
                Flexible(
                  flex: 2,
                  fit: FlexFit.loose,
                  child: AlarmCounterTile(),
                ),
              ],
            )),
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
}
