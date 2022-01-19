import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';
import 'package:uke_mlab/models/data_models/model_graphdata.dart';
import 'package:uke_mlab/models/data_models/model_nibd.dart';
import 'package:uke_mlab/utilities/enums/sensor.dart';

///Creates a [SfCartesianChart] to Display a History Graph. Example Use: NIBD History
///
///Needs to be Instanciated with a [Map<String,Object?>] for the Graph data that should be Displayed.
///The Data [Object] of this Map should be of Type [NIBDdata] for a NIBD History for Example.
///
///Uses [findMax] to Find the Maximum in the Data to Configure the Scaling of the Graph.
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

  /// Efficient way to find min and Max of the Y-Axis Interval that should be Rendered in [HistoryGraph] given the data in [graphData].
  double findMax(String type, DataModelNIBD dataModel) {
    List dataList;
    switch (type) {
      case 'max':
        dataList = (List.generate(dataModel.graphData.length,
            (index) => dataModel.graphData[index].systolicPressure));
        dataList.sort;
        double max = dataList.last.toDouble();
        print(max);
        return dataList.isEmpty ? 150.0 : max;
      case 'min':
        dataList = (List.generate(dataModel.graphData.length,
            (index) => dataModel.graphData[index].diastolicPressure));
        dataList.sort;
        double min = dataList.last.toDouble();
        print(min);
        return dataList.isEmpty ? 150.0 : min;
      default:
        return 0.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    DataModelNIBD dataModel = Get.find<DataModelNIBD>(tag: sensor.name);
    return Obx(
      () => SfCartesianChart(
        tooltipBehavior: TooltipBehavior(enable: true),
        backgroundColor: Theme.of(context).cardColor,
        primaryYAxis: NumericAxis(
          plotOffset: 5,
          desiredIntervals: 10,
          //maximum: 150.0, //findMax('max', dataModel) + 5,
          //minimum: 0.0, //findMax('min', dataModel) - 5,
          majorGridLines: MajorGridLines(
            width: 1,
            color: Theme.of(context).shadowColor,
            dashArray: const <double>[2, 3],
          ),
        ),
        primaryXAxis: DateTimeAxis(
          dateFormat: DateFormat.Hm(),
          plotOffset: 10,
          desiredIntervals: 25,
          majorGridLines:
              MajorGridLines(width: 0, color: Theme.of(context).shadowColor),
        ),
        series: [
          // Renders scatter chart
          ScatterSeries(
            markerSettings: const MarkerSettings(
                height: 10,
                width: 10,
                // Scatter will render in diamond shape
                shape: DataMarkerType.diamond),
            trendlines: <Trendline>[
              Trendline(
                  dashArray: <double>[2, 3],
                  type: TrendlineType.movingAverage,
                  color: Colors.redAccent)
            ],
            color: dataModel.color,
            // DONT DELETE .value, syncfusion would break in combination wiht Getx
            dataSource: dataModel.graphData.value,
            xValueMapper: (ChartData data, _) => data.time,
            yValueMapper: (ChartData data, _) => data.meanArterialPressure,
          ),
          HiloSeries(
            enableTooltip: true,
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
