import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/models/model.dart';

import 'package:uke_mlab/models/enums.dart';
import 'package:uke_mlab/widgets/value_box/value_box_state.dart';

// highest level widget that is always called when ValueBox is needed
// --> initialize DataModel here and give attributes to children

class ValueBoxTile extends StatelessWidget {
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
    DataModel dataModel = Get.find<DataModel>(tag: sensor.toString());

    return type == 'regular'
        ? ValueBoxState(dataModel: dataModel)
        : Expanded(
            child: Container(
              color: const Color(0xFF25232A),
              margin: const EdgeInsets.only(right: 8, bottom: 8),
              child: Column(
                children: [
                  Flexible(
                    flex: 1,
                    child: Container(
                      margin: const EdgeInsets.only(top: 4, bottom: 4),
                      child: Text(
                        dataModel.title,
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
