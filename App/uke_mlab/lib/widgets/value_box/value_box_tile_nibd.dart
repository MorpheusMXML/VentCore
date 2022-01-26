import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/models/data_models/model_absolute.dart';
import 'package:uke_mlab/models/system_state.dart';
import 'package:uke_mlab/utilities/app_theme.dart';
import 'package:uke_mlab/utilities/enums/alarm_status.dart';
import 'package:uke_mlab/utilities/enums/sensor.dart';
import 'package:uke_mlab/widgets/value_box/value_box_tile.dart';

/// This Class renders the Absolute Value Tile for the NIBD Measurements.
///
/// It requires the [sensorEnumAbsolute] of the Systolic and Diastolic measurement. Further specifies a [type] to decide Wether the Tile is rendered with a Headline or not.
/// The [type] can be overwritten otherwise defaults to 'withHeadline'.
///
/// The [Widget] that is returned by this Class uses [GetX] to find the corresponding [DataModelAbsolute] for the Systolic and Diastolic Measurements.
/// Further uses two [ValueBoxState.withHeadline()] to house the mentioned Datapoints. One can understand this Class as a Wrapper for a normal AbsoluteTile to Group the NIBD Measures in one Tile.
/// ### Important Notice
/// This Widget is implemented to take the space of 2 'usual' Absolute Tiles. So the NIBD Absolute Tile returned from this needs a Full row in the AbsoluteTile Section on the Screen.
/// This Special size was chosen due to the difference of the NIBD Data to other Absolute Datapoints. NIBD always has at least 2 Datapoints with corresponing Alarm Borders.
/// {@category Widgets}
/// {@subCategory Value Box}
class ValueBoxTileNIBD extends StatelessWidget {
  /// Renders the Absolute Value Tile for NIBD Measurements. Requires the [sensorEnumAbsolute] for Systolic and Diastolic Pressure.

  /// key for the sensorEnumAbsolute representing sys
  final sensorEnumAbsolute sensorAbsoluteSYS;

  /// key for the sensorEnumAbsolute representing dia
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
    final ThemeData theme = Theme.of(context);
    // sensorAbsolute is not null since IF sensorGraph == null, sensorAbsolute is required // sensorAbsolute is not null since IF sensorGraph == null, sensorAbsolute is required
    DataModelAbsolute dataModelSYS = Get.find<DataModelAbsolute>(tag: sensorAbsoluteSYS.name);
    SystemState systemState = Get.find<SystemState>();

    return Container(
      color: theme.primarySwatch[50],
      margin: const EdgeInsets.only(left: 4, right: 4, top: 4, bottom: 4),
      child: Column(
        children: [
          Flexible(
            flex: 1,

            /// [Container] used to render the ShortString of the [DataModelAbsolute] Results in the [String] 'NIBD' if called with NIBD DataModel.
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Obx(
                  () => Flexible(
                    flex: 1,
                    child: Container(
                      color: evaluateBorderColor(context, sensorEnumAbsolute.sysAbsolute, systemState.alarmState),
                    ),
                  ),
                ),
                SizedBox(
                  width: 2 * 37 + 8,
                  child: Center(
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
                ),
                Flexible(
                  flex: 1,
                  child: Obx(
                    () => Container(
                      color: evaluateBorderColor(context, sensorEnumAbsolute.diaAbsolute, systemState.alarmState),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            flex: 3,
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              //Systolic Absolute Box
              Expanded(
                child: ValueBoxTile.withHeadline(
                  sensorAbsolute: sensorEnumAbsolute.sysAbsolute,
                  optAbreviationTitle: sensorAbsoluteSYS.abbreviation,
                  superNIBD: true,
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              //Diastolic Absolute Box
              Expanded(
                child: ValueBoxTile.withHeadline(
                  sensorAbsolute: sensorEnumAbsolute.diaAbsolute,
                  optAbreviationTitle: sensorAbsoluteDIA.abbreviation,
                  superNIBD: true,
                ),
              ),
            ]),
          )
        ],
      ),
    );
  }

  /// Helper method to evaluate the backgroundcolor for alarms (default != [Theme.of(context).primarySwatch[50]])
  Color? evaluateBorderColor(BuildContext context, sensorEnumAbsolute sensorKey,
      RxMap<sensorEnumAbsolute, Map<String, dynamic>> alarmState) {
    final ThemeData theme = Theme.of(context);
    alarmStatus? alarm = alarmState[sensorKey]!["status"];

    switch (alarm) {
      case alarmStatus.high:
      case alarmStatus.middle:
      case alarmStatus.warning:
        return alarmState[sensorKey]!["color"];
      case alarmStatus.confirmed:
        return (alarmState[sensorKey]!["color"] as Color).withOpacity(0.65);
      default:
        return theme.primarySwatch[50];
    }
  }
}
