import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/models/data_models/model_absolute.dart';
import 'package:uke_mlab/models/data_models/model_graph.dart';
import 'package:uke_mlab/models/screen_element_models/absolute_alarm_field_model.dart';
import 'package:uke_mlab/models/system_state.dart';
import 'package:uke_mlab/utilities/enums/alarm_status.dart';

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
    final SystemState systemState = Get.find<SystemState>();
    // TODO: Also check for alarms here (=>build red container if alarm) + confirmation button above toggle_mode_button
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
          :
          // called with headline case
          Obx(
              () => Container(
                color: evaluateBorderColor(context, systemState.alarmState),
                margin: const EdgeInsets.only(right: 8, bottom: 8),
                child: Column(
                  children: [
                    Flexible(
                      flex: 1,
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: (Get.width - 12 - 12) /
                                  (2 + 1) *
                                  1 /
                                  2 *
                                  1 -
                              8 -
                              37 -
                              37, // step in between solution with constansts, numbers from flexibles and paddings/margins
                          // unsure why - 37 and not -35 (padding and margin f*up?)
                        ),
                        child: Container(
                          margin: const EdgeInsets.only(
                            top: 4,
                            bottom: 4,
                          ), //left: 35, right: 35),
                          color: Theme.of(context).focusColor,
                          child: Center(
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

  Color evaluateBorderColor(BuildContext context,
      RxMap<sensorEnumAbsolute, Map<String, dynamic>> alarmState) {
    alarmStatus? alarm = alarmState[sensorAbsolute]!["status"];
    switch (alarm) {
      case alarmStatus.high:
      case alarmStatus.middle:
        return alarmState[sensorAbsolute]!["color"];
      case alarmStatus.confirmed:
      default:
        return Theme.of(context).focusColor;
    }
  }
}
