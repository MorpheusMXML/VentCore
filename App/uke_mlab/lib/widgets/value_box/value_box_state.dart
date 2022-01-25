import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:uke_mlab/models/data_models/model_absolute.dart';

import 'package:uke_mlab/widgets/value_box/value_box_container.dart';
import 'package:uke_mlab/widgets/value_box/value_box_settings.dart';

class ValueBoxState extends StatelessWidget {
  final DataModelAbsolute dataModel;
  final double settingsWidth;
  final double settingsHeight;
  final String? optAbreviationTitle;

  const ValueBoxState({
    Key? key,
    required this.dataModel,
    this.settingsHeight = 100,
    this.settingsWidth = 60,
    this.optAbreviationTitle,
  }) : super(key: key);

  const ValueBoxState.withHeadline({
    Key? key,
    required this.dataModel,
    this.settingsHeight = 100,
    this.settingsWidth = 35,
    this.optAbreviationTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => dataModel.expanded.value
          ? Container(
              color: Theme.of(context).shadowColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ValueBoxSettings.lower(
                    dataModel: dataModel,
                    width: settingsWidth,
                    height: settingsHeight,
                  ),
                  ValueBoxContainer(
                    dataModelAbsolute: dataModel,
                    optAbreviationTitle: optAbreviationTitle,
                  ),
                  ValueBoxSettings.upper(
                    dataModel: dataModel,
                    height: settingsHeight,
                    width: settingsWidth,
                  ),
                ],
              ),
            )
          : settingsWidth == 60
              ? ValueBoxContainer(
                  dataModelAbsolute: dataModel,
                  optAbreviationTitle: optAbreviationTitle,
                )
              : ConstrainedBox(
                  constraints: BoxConstraints(
                      maxWidth: (Get.width - 12 - 12) / (2 + 1) * 1 / 2 * 1 -
                          8 -
                          37 -
                          37),
                  child: ValueBoxContainer(
                    dataModelAbsolute: dataModel,
                    optAbreviationTitle: optAbreviationTitle,
                  ),
                ),
    );
  }
}
