import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/models/model_absolute.dart';
import 'package:uke_mlab/models/model_graph.dart';

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
    const double aspectRatio =
        1.1; // TODO: should be 1 but then we have a pixel overflow -> 255 and others are too big in current configuration
    if (dataModelGraph == null) {
      return AspectRatio(
        aspectRatio: aspectRatio,
        child: ElevatedButton(
          style: ButtonStyle(
              shape: MaterialStateProperty.all(const RoundedRectangleBorder()),
              backgroundColor:
                  MaterialStateProperty.all(Theme.of(context).cardColor)),
          onPressed: () => dataModelAbsolute!.tapped.toggle(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Top
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(dataModelAbsolute!.abbreviation,
                    style: TextStyle(color: dataModelAbsolute!.color)),
                Obx(() => Text(dataModelAbsolute!.upperAlarmBound.toString(),
                    style: TextStyle(color: dataModelAbsolute!.color)))
              ]),

              // Middle
              Obx(() => Text(
                  dataModelAbsolute!.absoluteValue.value.toInt().toString(),
                  style: TextStyle(
                      color: dataModelAbsolute!.color, fontSize: 50.0))),

              // Bottom
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Obx(() => Text(dataModelAbsolute!.lowerAlarmBound.toString(),
                    style: TextStyle(color: dataModelAbsolute!.color))),
                Text(dataModelAbsolute!.unit,
                    style: TextStyle(color: dataModelAbsolute!.color))
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
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Container(
                  margin: EdgeInsets.only(left: 15),
                  child: Text(dataModelGraph!.graphTitle,
                      style: TextStyle(color: dataModelGraph!.color)),
                ),
                Container()
              ]),

              // Middle
              Obx(() => Text(
                  dataModelGraph!.singleData.value.value.toInt().toString(),
                  style:
                      TextStyle(color: dataModelGraph!.color, fontSize: 50.0))),

              // Bottom
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Container(),
                Container(
                  margin: EdgeInsets.only(right: 15),
                  child: Text(dataModelGraph!.yAxisTitle,
                      style: TextStyle(color: dataModelGraph!.color)),
                )
              ]),
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
