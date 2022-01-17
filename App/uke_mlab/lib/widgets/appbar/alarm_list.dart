import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/models/general_alarms.dart';
import 'package:uke_mlab/models/system_state.dart';

import 'package:uke_mlab/utilities/statusbar_constants.dart';
import 'package:uke_mlab/widgets/appbar/alarm_field_tile.dart';

class AlarmList extends StatelessWidget {
  const AlarmList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GeneralAlarms generalAlarms = Get.find<GeneralAlarms>();
    double statusBarHeight = MediaQuery.of(context).padding.top;

    return Obx(
      () => ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: Get.height - statusBarHeight,
          maxWidth: StatusBarConstants.alarmListWidth +
              2 * StatusBarConstants.horizontalMargin,
        ),
        child: Container(
          margin: const EdgeInsets.only(
              bottom: StatusBarConstants.verticalMargin,
              right: StatusBarConstants.horizontalMargin,
              left: StatusBarConstants.horizontalMargin),
          child: Column(
            children: [
              Container(
                width: StatusBarConstants.alarmListWidth -
                    2 * StatusBarConstants.horizontalMargin,
                height: StatusBarConstants.verticalMargin,
                color: Theme.of(context).shadowColor,
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
                          color: Theme.of(context).shadowColor,
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
