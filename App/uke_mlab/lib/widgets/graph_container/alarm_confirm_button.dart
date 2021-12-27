import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/models/enums.dart';
import 'package:uke_mlab/models/model.dart';

class AlarmConfirmButton extends StatelessWidget {
  final sensorEnum sensor;
  const AlarmConfirmButton({
    Key? key,
    required this.sensor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DataModel dataModel = Get.find<DataModel>(tag: sensor.toString());
    
    return ElevatedButton(
      onPressed: () => dataModel.alarmState.value = 'suppressed',
      child: const Text("Confirm"),
    );
  }
}
