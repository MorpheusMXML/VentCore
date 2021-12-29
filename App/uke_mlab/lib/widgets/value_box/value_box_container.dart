import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:uke_mlab/utilities/screen_controller.dart';

import 'package:uke_mlab/models/enums.dart';
import 'package:uke_mlab/models/model.dart';
import 'package:uke_mlab/widgets/value_box/value_box.dart';
import 'package:uke_mlab/widgets/value_box/value_box_settings.dart';

class ValueBoxContainer extends StatelessWidget {
  final sensorEnum sensor;

  const ValueBoxContainer({
    Key? key,
    required this.sensor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ScreenController screenController;
    final DataModel dataModel = Get.find<DataModel>(tag: sensor.toString());

    // TODO: Also check for alarms here (red container)

    return Obx(
      () => dataModel.tapped.value
          ? Container(
              color: const Color(0xFF49454F),
              child: Row(
                children: [
                  ValueBoxSettings(dataModel: dataModel, type: 'lower'),
                  AspectRatio(
                      aspectRatio: 1,
                      child: ElevatedButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                                const RoundedRectangleBorder()),
                            backgroundColor: MaterialStateProperty.all(
                                const Color(0xFF2A2831))),
                        onPressed: () => dataModel.tapped.toggle(),
                        child: ValueBox(dataModel: dataModel),
                      )),
                  ValueBoxSettings(dataModel: dataModel, type: 'upper'),
                ],
              ),
            )
          : AspectRatio(
              aspectRatio: 1,
              child: ElevatedButton(
                style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                        const RoundedRectangleBorder()),
                    backgroundColor:
                        MaterialStateProperty.all(const Color(0xFF2A2831))),
                onPressed: () => dataModel.tapped.toggle(),
                child: ValueBox(dataModel: dataModel),
              ),
            ),
    );
  }
}
