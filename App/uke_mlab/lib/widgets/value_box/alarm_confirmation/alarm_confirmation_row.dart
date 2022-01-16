import 'package:flutter/material.dart';
import 'package:uke_mlab/widgets/graph_container/alarm_confirm_button.dart';
import 'package:uke_mlab/widgets/value_box/alarm_confirmation/alarm_confirmation_button_all.dart';
import 'package:uke_mlab/widgets/value_box/alarm_confirmation/alarm_confirmation_button_single.dart';

class AlarmConfirmationRow extends StatelessWidget {
  const AlarmConfirmationRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Expanded(
            flex: 5,
            child: AlarmConfirmationButtonAll(),
          ),
          Spacer(flex: 1),
          Expanded(
            flex: 5,
            child: AlarmConfirmationButtonSingle(),
          )
        ],
      ),
    );
  }
}
