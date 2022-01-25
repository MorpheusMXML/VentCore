import 'package:flutter/material.dart';
import 'package:uke_mlab/utilities/constants/absolute_alarm_field_constants.dart';
import 'package:uke_mlab/widgets/value_box/alarm_confirmation/alarm_confirmation_button_confirm_all.dart';
import 'package:uke_mlab/widgets/value_box/alarm_confirmation/alarm_confirmation_button_single_list_expansion_button.dart';

class AlarmConfirmationRow extends StatelessWidget {
  const AlarmConfirmationRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10, right: AbsoluteAlarmFieldConst.horizontalMargin),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Expanded(
            flex: 1,
            child: AlarmConfirmationButtonAll(),
          ),
          // Spacer(flex: 1),
          Expanded(
            flex: 1,
            child: AlarmConfirmationButtonSingleListExpansion(),
          )
        ],
      ),
    );
  }
}
