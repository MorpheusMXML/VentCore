import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:uke_mlab/utilities/screen_controller.dart';
import 'package:uke_mlab/models/model.dart';
import 'package:uke_mlab/widgets/value_box/value_box_container.dart';
import 'package:uke_mlab/widgets/value_box/value_box_settings.dart';

class ValueBoxState extends StatelessWidget {
  final DataModel dataModel;
  final double settingsWidth;
  final double settingsHeight;
  final String type;

  const ValueBoxState({
    Key? key,
    required this.dataModel,
    this.type = 'regular',
    this.settingsHeight = 100,
    this.settingsWidth = 60,
  }) : super(key: key);

  const ValueBoxState.withHeadline({
    Key? key,
    required this.dataModel,
    this.type = 'withHeadline',
    this.settingsHeight = 100,
    this.settingsWidth = 30,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ScreenController screenController;

    // TODO: Also check for alarms here (red container)

    return Obx(
      () => dataModel.tapped.value
          ? Container(
              color: const Color(0xFF49454F),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ValueBoxSettings.lower(
                    dataModel: dataModel,
                    width: settingsWidth,
                    height: settingsHeight,
                  ),
                  ValueBoxContainer(dataModel: dataModel),
                  ValueBoxSettings.upper(
                    dataModel: dataModel,
                    height: settingsHeight,
                    width: settingsWidth,
                  ),
                ],
              ),
            )
          : ValueBoxContainer(dataModel: dataModel),
    );
  }
}
