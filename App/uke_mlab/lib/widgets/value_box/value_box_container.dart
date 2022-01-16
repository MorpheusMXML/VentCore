import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/models/model_absolute.dart';
import 'package:uke_mlab/models/model_graph.dart';
import 'package:uke_mlab/utilities/enums/sensor.dart';

class ValueBoxContainer extends StatelessWidget {
  final DataModelAbsolute? dataModelAbsolute;
  final DataModelGraph? dataModelGraph;
  final String? optAbreviationTitle; // TODO overwrite title if not null

  const ValueBoxContainer({
    Key? key,
    required this.dataModelAbsolute,
    this.dataModelGraph,
    this.optAbreviationTitle,
  }) : super(key: key);

  const ValueBoxContainer.withoutAbsolute({
    Key? key,
    this.dataModelAbsolute,
    required this.dataModelGraph,
    this.optAbreviationTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double aspectRatio = 1.1; // TODO: should be 1 but then we have a pixel overflow -> 255 and others are too big in current configuration
    double fontSize = 17;
    double fontSizeCenter = 44;
    // could be done via template pattern for better code quality
    if (dataModelGraph == null) {

      //When NIBD: avoid overflow.
      if(dataModelAbsolute!.abbreviation == sensorEnumAbsolute.sysAbsolute.abbreviation || dataModelAbsolute!.abbreviation == sensorEnumAbsolute.diaAbsolute.abbreviation){
        fontSizeCenter = 40;
        fontSize = 14;
      }
      return AspectRatio(
        aspectRatio: aspectRatio,
        child: ElevatedButton(
          style: ButtonStyle(
              shape: MaterialStateProperty.all(const RoundedRectangleBorder()), backgroundColor: MaterialStateProperty.all(Theme.of(context).cardColor)),
          onPressed: () => dataModelAbsolute!.tapped.toggle(),
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
                    ),
                  ),
                )
              ]),

              // Middle
              Obx(
                () => Text(
                  dataModelAbsolute!.floatRepresentation
                      ? dataModelAbsolute!.absoluteValue.value.toString()
                      : dataModelAbsolute!.absoluteValue.value.toInt().toString(),
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
                    ),
                  ),
                ),
                Text(
                  dataModelAbsolute!.unit,
                  style: TextStyle(
                    color: dataModelAbsolute!.color,
                    fontSize: fontSize,
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
            color: Theme.of(context).cardColor,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Top
              Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Flexible(
                    child: Text(
                      dataModelGraph!.graphTitle,
                      style: TextStyle(
                        color: dataModelGraph!.color,
                        fontSize: fontSize,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    "Graph\nValue",
                    style: TextStyle(
                      color: dataModelGraph!.color,
                      fontSize: fontSize,
                    ),
                  ),
                ]),
              ),

              // Middle

              Obx(
                () => Text(
                  (dataModelGraph!.singleData.value.value > -1.0 && dataModelGraph!.singleData.value.value < 1.0)
                      ? dataModelGraph!.singleData.value.value.toStringAsFixed(1)
                      : dataModelGraph!.singleData.value.value.toInt().toString(),
                  style: TextStyle(
                    color: dataModelGraph!.color,
                    fontSize: fontSizeCenter,
                  ),
                ),
              ),

              // Bottom
              Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Container(),
                  Text(
                    dataModelGraph!.yAxisTitle,
                    style: TextStyle(
                      color: dataModelGraph!.color,
                      fontSize: fontSize,
                    ),
                  ),
                ]),
              ),
            ],
          ),
        ),
      );
    } else {
      throw Exception("ValueBoxContainer was given both dataModelGraph and DataModelAbsolute");
    }
  }
}
