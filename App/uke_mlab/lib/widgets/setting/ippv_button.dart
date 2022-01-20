import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/models/system_state.dart';
import 'package:uke_mlab/utilities/constants/absolute_alarm_field_constants.dart';

class IPPVButton extends StatelessWidget {
  const IPPVButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SystemState systemState = Get.find<SystemState>();

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(
        left: AbsoluteAlarmFieldConst.horizontalMargin,
        right: AbsoluteAlarmFieldConst.horizontalMargin,
        top: AbsoluteAlarmFieldConst.verticalMargin,
      ),
      child: Center(
        child: Obx(
          () => Container(
            decoration: BoxDecoration(
                color: Colors.lightBlue[300],
                borderRadius: const BorderRadius.all(Radius.circular(16))),
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
                isExpanded: true,
                value: systemState.ippvModel.selectedIPPVMode.value,
                onChanged: (newValue) {
                  systemState.ippvModel.selectedIPPVMode.value = '$newValue';
                },
                items: <String>['Mode 1', 'Mode 2', 'Mode 3'].map((value) {
                  return DropdownMenuItem(
                    child: Container(
                        margin: const EdgeInsets.only(left: 8),
                        child: Text(value)),
                    value: value,
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
