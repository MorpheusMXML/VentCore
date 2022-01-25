import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';
import 'package:uke_mlab/models/data_models/model_graphdata.dart';
import 'package:uke_mlab/models/data_models/model_nibd.dart';
import 'package:uke_mlab/utilities/app_theme.dart';
import 'package:uke_mlab/utilities/enums/sensor.dart';

///Creates a [SfCartesianChart] to Display a History Graph. Example Use: NIBD History
///
///Needs to be Instanciated with a [sensorEnumGraph] for the Graph data that should be Displayed.
///The DataModel this finds with [GetX] depends on the specified SensorEnum.
///If instanciated with NIBD Sensor: [DataModelNIBD] this houses [ChartData.asNIBD()] for a NIBD History for Example.
///
///DEPRECATED: Uses [findMax] to Find the Maximum in the Data to Configure the Scaling of the Graph.
///
///Uses a [ScatterSeries] to Plot the MAD Value of the BloodPressure Measurement
///Uses [HiloSeries] to Plot the Systolic and Diastolic Pressure as Hi and Low of the Series.
///
class HistoryGraph extends StatelessWidget {
  final sensorEnumGraph sensor;

  const HistoryGraph({
    Key? key,
    required this.sensor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    DataModelNIBD dataModel = Get.find<DataModelNIBD>(tag: sensor.name);
    return Obx(
      () => SfCartesianChart(
        tooltipBehavior: TooltipBehavior(enable: true),
        backgroundColor: theme.primarySwatch[40],
        primaryYAxis: NumericAxis(
          plotOffset: 5,
          desiredIntervals: 10,
          majorGridLines: MajorGridLines(
            width: 1,
            color: theme.primarySwatch[20],
            dashArray: const <double>[2, 3],
          ),
        ),
        primaryXAxis: DateTimeAxis(
          dateFormat: DateFormat.Hm(),
          plotOffset: 10,
          desiredIntervals: 25,
          majorGridLines: MajorGridLines(
            width: 0,
            color: theme.primarySwatch[20],
          ),
        ),
        series: [
          /// Renders scatter chart to display the MAD.
          ScatterSeries(
            markerSettings: const MarkerSettings(
                height: 10,
                width: 10,

                /// Scatter will render in diamond shape
                shape: DataMarkerType.diamond),
            trendlines: <Trendline>[
              Trendline(
                  dashArray: <double>[2, 3],
                  type: TrendlineType.movingAverage,
                  color: Colors.redAccent)
            ],
            color: dataModel.color,
            //ARNE Sagt: Löscht du das = Kopf Ab!!!!!!11!
            // ignore: invalid_use_of_protected_member
            dataSource: dataModel.graphData.value,
            xValueMapper: (ChartData data, _) => data.time,
            yValueMapper: (ChartData data, _) => data.meanArterialPressure,
          ),

          /// Renders the Systolic and Diastolic Datapoints as a Hi-Lo Error Bar.
          HiloSeries(
            enableTooltip: true,
            // ignore: invalid_use_of_protected_member
            dataSource: dataModel.graphData.value,
            color: Colors.red,
            xValueMapper: (ChartData data, _) => data.time,
            lowValueMapper: (ChartData data, _) => data.diastolicPressure,
            highValueMapper: (ChartData data, _) => data.systolicPressure,
            markerSettings: const MarkerSettings(
                shape: DataMarkerType.horizontalLine,
                width: 10,
                isVisible: true),
          ),
        ],
      ),
    );
  }
}
