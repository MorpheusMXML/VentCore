import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/models/model.dart';

import 'package:uke_mlab/utilities/enums/sensor.dart';
import 'package:uke_mlab/widgets/value_box/value_box_state.dart';

class ValueBoxTile extends StatelessWidget {
  /// highest level widget that is always called when a ValueBox is needed
  ///
  /// [DataModel] is initialized here and attributes provided for children
  /// Categorize ValueBox in "regular" and "withHeadline"
  /// "withHeadline" uses [Flexible] to position a readable Headline onto the actual [ValueBoxTile]
  final sensorEnum sensor;
  final String type;

  const ValueBoxTile({
    Key? key,
    required this.sensor,
    this.type = 'regular',
  }) : super(key: key);

  const ValueBoxTile.withHeadline({
    Key? key,
    required this.sensor,
    this.type = 'withHeadline',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DataModel dataModel = Get.find<DataModel>(tag: sensor.name);

    return type == 'regular'
        ? ValueBoxState(dataModel: dataModel)
        : Expanded(
            child: Container(
              color: Theme.of(context).focusColor,
              margin: const EdgeInsets.only(right: 8, bottom: 8),
              child: Column(
                children: [
                  Flexible(
                    flex: 1,
                    child: Container(
                      margin: const EdgeInsets.only(top: 4, bottom: 4),
                      child: Text(
                        dataModel.displayShortString,
                        style: TextStyle(
                          decoration: TextDecoration.none,
                          color: dataModel.color,
                          fontSize: 20,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 3,
                    child: ValueBoxState.withHeadline(dataModel: dataModel),
                  ),
                ],
              ),
            ),
          );
  }
}
