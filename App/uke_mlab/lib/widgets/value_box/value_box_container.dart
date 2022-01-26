import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/models/data_models/model_absolute.dart';
import 'package:uke_mlab/models/data_models/model_graph.dart';
import 'package:uke_mlab/utilities/app_theme.dart';
import 'package:uke_mlab/utilities/enums/sensor.dart';

/// Contains a widget representing the current value, boundaries, name and unit of a [DataModelAbsolute].
///
/// For a [DataModelGraph] without associated [DataModelAbsolute] the current value of the graph is represented if [ValueBoxContainer.withoutAbsolute] was used.
/// Either [dataModelAbsolute] or [dataModelGraph] must be null
class ValueBoxContainer extends StatelessWidget {
  /// The [DataModelAbsolute] to represent.
  final DataModelAbsolute? dataModelAbsolute;

  /// The [DataModelAbsolute] to represent.
  final DataModelGraph? dataModelGraph;

  /// An optional title if the default one is not wished for
  final String? optAbreviationTitle;

  /// Standard constructor, taking the [dataModelAbsolute] for representation.
  ///
  /// [dataModelGraph] should be null
  const ValueBoxContainer({
    Key? key,
    required this.dataModelAbsolute,
    this.dataModelGraph,
    this.optAbreviationTitle,
  }) : super(key: key);

  /// Constructor for graphs without [dataModelAbsolute], taking the [dataModelGraph] for representation.
  ///
  /// [dataModelAbsolute] should be null
  const ValueBoxContainer.withoutAbsolute({
    Key? key,
    this.dataModelAbsolute,
    required this.dataModelGraph,
    this.optAbreviationTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final GlobalKey globalKey = GlobalKey();
    const double aspectRatio = 1.1;
    double fontSize = 17;
    double fontSizeCenter = 44;
    // could be done via template pattern for better code quality
    if (dataModelGraph == null) {
      //When NIBD: avoid overflow.
      if (dataModelAbsolute!.abbreviation ==
              sensorEnumAbsolute.sysAbsolute.abbreviation ||
          dataModelAbsolute!.abbreviation ==
              sensorEnumAbsolute.diaAbsolute.abbreviation) {
        fontSizeCenter = 40;
        fontSize = 14;
      }
      return AspectRatio(
        aspectRatio: aspectRatio,
        child: ElevatedButton(
          key: globalKey,
          style: theme.valueBoxContainerButtonStyle,
          onPressed: () {
            dataModelAbsolute!.expanded = !dataModelAbsolute!.expanded;
            dataModelAbsolute!.expanded
                ? dataModelAbsolute!.showOverlay(this, globalKey, context)
                : dataModelAbsolute!.hideOverlay();
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Top
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(
                  dataModelAbsolute!.abbreviation,
                  style: TextStyle(
                    color: dataModelAbsolute!.color,
                    fontSize: fontSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Obx(
                  () => Text(
                    dataModelAbsolute!.floatRepresentation
                        ? dataModelAbsolute!.upperAlarmBound.toString()
                        : dataModelAbsolute!.upperAlarmBound.toInt().toString(),
                    style: TextStyle(
                      color: dataModelAbsolute!.color,
                      fontSize: fontSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ]),

              // Middle
              Obx(
                () => Text(
                  dataModelAbsolute!.floatRepresentation
                      ? dataModelAbsolute!.sensorKey == sensorEnumAbsolute.mve
                          ? dataModelAbsolute!.absoluteValue.value
                              .toStringAsFixed(2)
                          : //give mve 2 decimals
                          dataModelAbsolute!.absoluteValue.value
                              .toStringAsFixed(1)
                      : dataModelAbsolute!.absoluteValue.value
                          .toInt()
                          .toString(),
                  style: TextStyle(
                    color: dataModelAbsolute!.color,
                    fontSize: fontSizeCenter,
                  ),
                ),
              ),

              // Bottom
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Obx(
                  () => Text(
                    dataModelAbsolute!.floatRepresentation
                        ? dataModelAbsolute!.lowerAlarmBound.toString()
                        : dataModelAbsolute!.lowerAlarmBound.toInt().toString(),
                    style: TextStyle(
                      color: dataModelAbsolute!.color,
                      fontSize: fontSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  dataModelAbsolute!.unit,
                  style: TextStyle(
                    color: dataModelAbsolute!.color,
                    fontSize: fontSize,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ]),
            ],
          ),
        ),
      );
    } else if (dataModelAbsolute == null) {
      return AspectRatio(
        aspectRatio: aspectRatio,
        child: Container(
          decoration: ShapeDecoration(
            shape: const RoundedRectangleBorder(),
            color: theme.primarySwatch[70],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Top
              Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          dataModelGraph!.graphTitle,
                          style: TextStyle(
                            color: dataModelGraph!.color,
                            fontSize: fontSize,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Text(
                        "Graph\nValue",
                        style: TextStyle(
                          color: dataModelGraph!.color,
                          fontSize: fontSize,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ]),
              ),

              // Middle

              Obx(
                () => Text(
                  (dataModelGraph!.singleData.value.value > -1.0 &&
                          dataModelGraph!.singleData.value.value < 1.0)
                      ? dataModelGraph!.singleData.value.value
                          .toStringAsFixed(1)
                      : dataModelGraph!.singleData.value.value
                          .toInt()
                          .toString(),
                  style: TextStyle(
                    color: dataModelGraph!.color,
                    fontSize: fontSizeCenter,
                  ),
                ),
              ),

              // Bottom
              Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(),
                      Text(
                        dataModelGraph!.yAxisTitle,
                        style: TextStyle(
                          color: dataModelGraph!.color,
                          fontSize: fontSize,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ]),
              ),
            ],
          ),
        ),
      );
    } else {
      throw Exception(
          "ValueBoxContainer was given both dataModelGraph and DataModelAbsolute");
    }
  }
}
