import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/models/enums.dart';
import 'package:uke_mlab/models/system_state.dart';

class GraphAlarmMessage extends StatelessWidget {
  final boundaryStateEnum? message;

  const GraphAlarmMessage({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SystemState systemState = Get.find<SystemState>();

    return Text(
      message.toString(),
      style: const TextStyle(color: Colors.white, fontSize: 20),
    );
  }
}
