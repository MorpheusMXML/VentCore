import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/models/model_absolute.dart';
import 'package:uke_mlab/utilities/enums/sensor.dart';
import 'package:uke_mlab/widgets/value_box/value_box_state.dart';

class ValueBoxTileNIBD extends StatelessWidget {
  final sensorEnumAbsolute sensorAbsoluteSYS;
  final sensorEnumAbsolute sensorAbsoluteDIA;

  final String type;

  const ValueBoxTileNIBD({
    Key? key,
    required this.sensorAbsoluteSYS,
    required this.sensorAbsoluteDIA,
    this.type = 'withHeadline',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DataModelAbsolute dataModelSYS = Get.find<DataModelAbsolute>(tag: sensorAbsoluteSYS.name);
    DataModelAbsolute dataModelDIA = Get.find<DataModelAbsolute>(
        tag: sensorAbsoluteDIA
            .name); // sensorAbsolute is not null since IF sensorGraph == null, sensorAbsolute is required // sensorAbsolute is not null since IF sensorGraph == null, sensorAbsolute is required
    return Expanded(
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
                  dataModelSYS.displayShortString,
                  style: TextStyle(
                    decoration: TextDecoration.none,
                    color: dataModelSYS.color,
                    fontSize: 20,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
            Flexible(
                flex: 1,
                child: Row(children: [
                  //Systolic Absolute Box
                  Flexible(
                    flex: 3,
                    child: ValueBoxState.withHeadline(
                      dataModel: dataModelSYS,
                      optAbreviationTitle: sensorAbsoluteSYS.abbreviation,
                    ),
                  ),
                  //Diastolic Absolute Box
                  Flexible(
                    flex: 3,
                    child: ValueBoxState.withHeadline(
                      dataModel: dataModelDIA,
                      optAbreviationTitle: sensorAbsoluteDIA.abbreviation,
                    ),
                  ),
                ]))
          ],
        ),
      ),
    );
  }
}
