import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class StyleController extends GetxController {
  final Color heartFreqColor = const Color(0xFF34C759);
  final Color breathFreqColor = const Color(0xFF0CECDD);
  final Color oxySatColor = const Color(0xFF007AFF);
  final Color co2Color = const Color(0xFFAf52DE);
  final Color pulseColor = const Color(0xFFFF00E4);
  final Color pawColor = const Color(0xFFEF5DA8);
  final Color tempColor = const Color(0xFFFF6482);
  final Color nibdColor = const Color(0xFFDC362E);

  final Color backgroundColor = const Color(0xFF1C1B1F);
  final Color appBar = const Color(0xFF1d192B);
  // Graph
  final Color graphBackgroundColor = const Color(0xFF2A2831);
  final Color gridLineColor = const Color(0xFF49454F);
  final MajorGridLines gridLineStyle =
      const MajorGridLines(width: 1, color: Color(0xFF49454F));

  // Value Tile
  final Color valueTileBackgroundColor = const Color(0xFF2A2831);
}
