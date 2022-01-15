import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/models/general_alarms.dart';
import 'package:uke_mlab/models/system_state.dart';

class AlarmList extends StatelessWidget {
  const AlarmList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Overlay(
      initialEntries: [],
    );
  }
}
