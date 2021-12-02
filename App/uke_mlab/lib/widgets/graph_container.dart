import 'dart:async';

import 'package:flutter/material.dart';
import 'package:uke_mlab/models/model.dart';
import 'package:uke_mlab/widgets/bell.dart';
import 'package:uke_mlab/widgets/value_box.dart';
import 'package:uke_mlab/widgets/graph.dart';

class GraphContainer extends StatelessWidget {
  final DataModel dataModel;

  const GraphContainer({
    Key? key,
    required this.dataModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      child: Row(
        children: [
          const Flexible(
            flex: 1,
            child: Bell(),
          ),
          const Flexible(
            flex: 6,
            child: Graph(),
          ),
          Flexible(
            flex: 2,
            child: ValueBox(
              textColor: 0xff0CECDD,
              backgroundColor: 0xff2A2831,
              dataModel: dataModel,
            ),
          )
        ],
      ),
    );
  }
}

//class ChartData {
//  ChartData(this.time, this.value);
//  final String time;
//  final double? value;
//}
