import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/models/model_absolute.dart';
import 'package:uke_mlab/utilities/enums/sensor.dart';
import 'package:uke_mlab/widgets/value_box/value_box_state.dart';

/// This Class renders the Absolute Value Tile for the NIBD Measurements.
///
/// It requires the [SensorEnumAbsolute] of the Systolic and Diastolic measurement. Further specifies a [type] to decide Wether the Tile is rendered with a Headline or not.
/// The [type] can be overwritten otherwise defaults to 'withHeadline'.
///
/// The [Widget] that is returned by this Class uses [GetX] to find the corresponding [DataModelAbsolute] for the Systolic and Diastolic Measurements.
/// Further uses two [ValueBoxState.withHeadline()] to house the mentioned Datapoints. One can understand this Class as a Wrapper for a normal AbsoluteTile to Group the NIBD Measures in one Tile.
/// ### Important Notice
/// This Widget is implemented to take the space of 2 'usual' Absolute Tiles. So the NIBD Absolute Tile returned from this needs a Full row in the AbsoluteTile Section on the Screen.
/// This Special size was chosen due to the difference of the NIBD Data to other Absolute Datapoints. NIBD always has at least 2 Datapoints with corresponing Alarm Borders.
class ValueBoxTileNIBD extends StatelessWidget {
  /// Renders the Absolute Value Tile for NIBD Measurements. Requires the [SensorEnumAbsoule] for Systolic and Diastolic Pressure.
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
    // sensorAbsolute is not null since IF sensorGraph == null, sensorAbsolute is required // sensorAbsolute is not null since IF sensorGraph == null, sensorAbsolute is required
    DataModelAbsolute dataModelSYS = Get.find<DataModelAbsolute>(tag: sensorAbsoluteSYS.name);
    DataModelAbsolute dataModelDIA = Get.find<DataModelAbsolute>(tag: sensorAbsoluteDIA.name);
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
                flex: 3,
                child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  //Systolic Absolute Box
                  Flexible(
                    flex: 2,
                    child: ValueBoxState.withHeadline(
                      dataModel: dataModelSYS,
                      optAbreviationTitle: sensorAbsoluteSYS.abbreviation,
                    ),
                  ),
                  Flexible(flex: 1, child: Container()),
                  //Diastolic Absolute Box
                  Flexible(
                    flex: 2,
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
