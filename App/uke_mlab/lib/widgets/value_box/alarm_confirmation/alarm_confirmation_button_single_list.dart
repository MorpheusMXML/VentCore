import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/models/model_absolute.dart';
import 'package:uke_mlab/models/system_state.dart';
import 'package:uke_mlab/utilities/constants/absolute_alarm_field_constants.dart';
import 'package:uke_mlab/utilities/enums/sensor.dart';

class AlarmButtonAbsoluteList extends StatelessWidget {
  const AlarmButtonAbsoluteList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemState systemState = Get.find<SystemState>();

    return Obx(() {
      Set<sensorEnumAbsolute>? set;
      if (systemState.selectedToggleView[0]) {
        set = systemState.absAlarmFieldModel.monitorSet;
      } else if (systemState.selectedToggleView[1]) {
        set = systemState.absAlarmFieldModel.ventilationSet;
      } else if (systemState.selectedToggleView[2]) {
        set = systemState.absAlarmFieldModel.defiSet;
      } else {
        throw Exception(
            "No Toggle view active while activated absolute tile single alarm overlay is active");
      }

      return ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: AbsoluteAlarmFieldConst.ippvHeight,
          maxWidth: AbsoluteAlarmFieldConst.width,
        ),
        child: Container(
          color: Theme.of(context).focusColor,
          padding: const EdgeInsets.only(
              left: AbsoluteAlarmFieldConst.horizontalMargin,
              right: AbsoluteAlarmFieldConst.horizontalMargin,
              top: AbsoluteAlarmFieldConst.verticalMargin * 2,
              bottom: AbsoluteAlarmFieldConst.verticalMargin * 2),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: set.map((sensor) {
              return Flexible(
                flex: 1,
                child: Container(
                  color: Theme.of(context).cardColor,
                  padding: const EdgeInsets.only(
                      top: AbsoluteAlarmFieldConst.verticalMargin / 2,
                      bottom: AbsoluteAlarmFieldConst.verticalMargin / 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        fit: FlexFit.loose,
                        child: Text(
                          "${sensor.name}:\n${systemState.alarmState[sensor]!["message"]}",
                          style: TextStyle(
                            color: Get.find<DataModelAbsolute>(tag: sensor.name)
                                .color,
                            fontSize: 20,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          minimumSize: Size(
                              60, AbsoluteAlarmFieldConst.ippvHeight / 4 - 20),
                          maximumSize: Size(
                              60, AbsoluteAlarmFieldConst.ippvHeight / 4 - 20),
                          primary: Get.find<DataModelAbsolute>(tag: sensor.name)
                              .color,
                          onPrimary: Theme.of(context).dividerColor,
                        ),
                        onPressed: () =>
                            {}, //TODO add behavior for buttons (deactivate alarm and make button non active)
                        child: const Icon(
                          Icons.check,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      );
    });
  }
}
