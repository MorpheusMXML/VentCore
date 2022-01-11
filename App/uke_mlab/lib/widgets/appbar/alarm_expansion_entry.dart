import 'package:flutter/material.dart';
import 'package:uke_mlab/models/general_alarms.dart';
import 'package:intl/intl.dart';
import 'package:uke_mlab/utilities/enums/non_graph_alarm.dart';

class AlarmExpansionEntry extends StatelessWidget {
  final AlarmListEntry data;
  const AlarmExpansionEntry({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const TextStyle textStyle = TextStyle(
      color: Colors.black,
      fontSize: 25,
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          flex: 3,
          child: Container(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              DateFormat.Hms().format(data.time),
              style: textStyle,
            ),
          ),
        ),
        Flexible(
          flex: 9,
          child: Center(
            child: Text(
              data.alarm.message,
              style: textStyle,
            ),
          ),
        ),
        Flexible(
          flex: 2,
          child: Container(),
        ),
      ],
    );
  }
}
