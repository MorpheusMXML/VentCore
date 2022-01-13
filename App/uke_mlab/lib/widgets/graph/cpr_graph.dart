import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:uke_mlab/utilities/enums/sensor.dart';
import 'package:uke_mlab/models/model.dart';

///This Class returns a [Obx] which in turn consists of a [SfCartesianChart] with two [NumericAxis].
///The Graph rendered with this displays a history of how good the CPR has been performed in relation to the compression depth.
///
///The [sensorEnum] parameter specifies the Sensor this Graph gets it data from.
///Also a correspondig [DataModel] for the CPR Graph is created with [GetX].
class CprGraph extends StatelessWidget {
  /// Creates a CPR Bar Graph to Indicate optimum pressure applied during CPR.
  final sensorEnum sensor;

  ///Creates Instance of the CPR Bar Graph
  const CprGraph({Key? key, required this.sensor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DataModel dataModel = Get.find<DataModel>(tag: sensor.name);

    return Obx(
      () => SfCartesianChart(
        tooltipBehavior: TooltipBehavior(enable: true),
        backgroundColor: Theme.of(context).cardColor,
        primaryYAxis: NumericAxis(
          //Turning off String Labels at the Axis
          labelStyle: const TextStyle(fontSize: 0.0001),

          ///PlotBands Create the green horizontal Line to Indicate the optimum depth Interval.
          plotBands: <PlotBand>[
            PlotBand(
              isVisible: true,
              start: 5,
              end: 5,
              borderWidth: 1,
              borderColor: Colors.green,
            ),
            PlotBand(
              isVisible: true,
              start: 6,
              end: 6,
              borderWidth: 1,
              borderColor: Colors.green,
            )
          ],
          isInversed: true,
          maximum: 9.5,
          minimum: 2,
          majorGridLines: MajorGridLines(
            width: 1,
            color: Theme.of(context).shadowColor,
          ),
        ),
        primaryXAxis: NumericAxis(
          //Turning off String Labels at the Axis
          labelStyle: const TextStyle(fontSize: 0.0001),
          desiredIntervals: 25,
          majorGridLines: MajorGridLines(width: 1, color: Theme.of(context).shadowColor),
        ),
        series: <ColumnSeries<CPRData, dynamic>>[
          ColumnSeries<CPRData, dynamic>(
              dataSource: dataModel.graphData.value,
              yValueMapper: (CPRData graphData, _) => graphData.yvalue,
              xValueMapper: (CPRData graphData, _) => graphData.xvalue,
              pointColorMapper: (CPRData graphData, _) => graphData.color)
        ],
      ),
    );
  }
}

///This Class represents CPR Data provided for the Scenatios.
///
///Holds a [int] for the x- & y-Axis Value. Note that the x-Axis Value is dependent on the Resolution specified in the Scenario Data which influences the Update Rates.
///Also Specifies a [Color] to signal the Pressure depth of performed CPR Compressions with green for the interval between 5 and 6. Otherwise red is Specified.
///This color Property is used to Color the Bars in the [CprGraph].
class CPRData {
  ///DataClass for CPR Graph in AED Screen.
  final int yvalue;
  final int xvalue;
  late Color color;

  ///Constructor for [this]. Sets x- & y-Axis paramets of this DataClass. Also Decides based on the y-Axis value specified, which color the resulting Bar in the CPR Graph should be colored in.
  ///
  /// ### General Information about the CPR Depth indicated in red and green.
  /// Please Consider the recommendations for a optimal CPR to understand why the Colors are set the way they are. (https://www.cprblspros.com/cpr-cheat-sheet-2022)
  ///
  CPRData({required this.yvalue, required this.xvalue}) {
    ///Named Parameter [yvalue] and [xvalue] to initialize the corresponding DataPoints for the Graph.
    if (yvalue >= 5 && yvalue <= 6) {
      color = Colors.green;
    } else {
      color = Colors.red;
    }
  }
}
