import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/models/model_absolute.dart';
import 'package:uke_mlab/models/model_graph.dart';

import 'package:uke_mlab/utilities/enums/sensor.dart';
import 'package:uke_mlab/widgets/value_box/value_box_container.dart';
import 'package:uke_mlab/widgets/value_box/value_box_state.dart';

/// highest level widget that is always called when a ValueBox is needed
///
/// [DataModelAbsolute] is found here and attributes provided for children
/// Categorize ValueBox in "regular" and "withHeadline"
/// "withHeadline" uses [Flexible] to position a readable Headline onto the actual [ValueBoxTile]
class ValueBoxTile extends StatelessWidget {
  final sensorEnumAbsolute? sensorAbsolute;
  final sensorEnumGraph? sensorGraph;
  final String? optAbreviationTitle; // TODO use this to override loaded title
  final String type;

//SensorMapping.sensorMap[sensor] as sensorEnumAbsolute

  const ValueBoxTile({
    Key? key,
    required this.sensorAbsolute,
    this.sensorGraph,
    this.optAbreviationTitle,
    this.type = 'regular',
  }) : super(key: key);

  const ValueBoxTile.withHeadline({
    Key? key,
    required this.sensorAbsolute,
    this.sensorGraph,
    this.optAbreviationTitle,
    this.type = 'withHeadline',
  }) : super(key: key);

  const ValueBoxTile.withoutAbsolute({
    Key? key,
    this.sensorAbsolute,
    required this.sensorGraph,
    this.optAbreviationTitle,
    this.type = 'regular',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (sensorGraph == null) {
      // could also be done via, but the relevant case disctinction here is whether there is a sensorGraph associated or not
      DataModelAbsolute dataModel = Get.find<DataModelAbsolute>(
          tag: sensorAbsolute
              ?.name); // sensorAbsolute is not null since IF sensorGraph == null, sensorAbsolute is required

      return type == 'regular'
          ? ValueBoxState(
              dataModel: dataModel,
              optAbreviationTitle: optAbreviationTitle,
            )
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
                      child: ValueBoxState.withHeadline(
                        dataModel: dataModel,
                        optAbreviationTitle: optAbreviationTitle,
                      ),
                    ),
                  ],
                ),
              ),
            );
    } else if (sensorAbsolute == null) {
      return ValueBoxContainer.withoutAbsolute(
        dataModelGraph: Get.find<DataModelGraph>(tag: sensorGraph!.name),
        optAbreviationTitle: optAbreviationTitle,
      );
    } else {
      throw Exception(
          "ValueBoxTile was given both a sensorAbsolute and sensorGraph");
    }
  }
}
