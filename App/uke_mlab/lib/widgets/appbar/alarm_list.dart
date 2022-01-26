import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/models/screen_element_models/general_alarms.dart';
import 'package:uke_mlab/models/system_state.dart';
import 'package:uke_mlab/utilities/app_theme.dart';

import 'package:uke_mlab/utilities/constants/statusbar_constants.dart';
import 'package:uke_mlab/widgets/appbar/alarm_field_tile.dart';

/// List of [GeneralAlarms] containing [AlarmFieldTile] corresponding to active [GeneralAlarms].
///
/// Only displayable if there is more than 1 [GeneralAlarms]
/// {@category Widgets}
/// {@subCategory Appbar}
class AlarmList extends StatelessWidget {
  const AlarmList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    GeneralAlarms generalAlarms = Get.find<SystemState>().generalAlarms;
    double statusBarHeight = MediaQuery.of(context).padding.top;

    return Obx(
      () => ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: Get.height - statusBarHeight,
          maxWidth: StatusBarConstants.alarmListWidth + 2 * StatusBarConstants.horizontalMargin,
        ),
        child: Container(
          margin: const EdgeInsets.only(
              bottom: StatusBarConstants.verticalMargin,
              right: StatusBarConstants.horizontalMargin,
              left: StatusBarConstants.horizontalMargin),
          child: Column(
            children: [
              Container(
                width: StatusBarConstants.alarmListWidth - 2 * StatusBarConstants.horizontalMargin,
                height: StatusBarConstants.verticalMargin,
                color: theme.primarySwatch[10],
              ),
              Flexible(
                fit: FlexFit.loose,
                child: ListView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.only(
                      right: StatusBarConstants.horizontalMargin,
                      left: StatusBarConstants.horizontalMargin,
                      //  bottom: StatusBarConstants.verticalMargin,
                    ),
                    itemCount: generalAlarms.alarmList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                          padding: const EdgeInsets.only(
                            bottom: StatusBarConstants.verticalMargin,
                            right: StatusBarConstants.horizontalMargin,
                            left: StatusBarConstants.horizontalMargin,
                          ),
                          color: theme.primarySwatch[10],
                          child: AlarmFieldTile(
                              data: generalAlarms.alarmList[index]));
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
