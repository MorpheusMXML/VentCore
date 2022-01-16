import 'package:flutter/material.dart';
import 'package:uke_mlab/models/general_alarms.dart';
import 'package:intl/intl.dart';
import 'package:uke_mlab/utilities/enums/non_graph_alarm.dart';

class AlarmFieldTile extends StatelessWidget {
  /// describes an entry for the possible dropDownButton menu in [AlarmExpansionTile]
  final AlarmListEntry data;
  const AlarmFieldTile({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const TextStyle textStyle = TextStyle(
      color: Colors.black,
      decoration: TextDecoration.none,
      fontSize: 25,
    );

    return Container(
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
        color: data.toColor(),
      ),
      child: Row(
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
        ],
      ),
    );
  }
}
