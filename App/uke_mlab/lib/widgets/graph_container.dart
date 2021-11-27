// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:uke_mlab/providers/mockup.dart';
import 'package:uke_mlab/widgets/bell.dart';
import 'package:uke_mlab/widgets/value_box.dart';
import 'package:uke_mlab/widgets/graph.dart';

class GraphContainer extends StatelessWidget {
  final List<ChartData> data;

  const GraphContainer({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      child: Row(
        children: [
          Flexible(
            flex: 1,
            child: Bell(),
          ),
          Flexible(
            flex: 6,
            child: Graph(data: data),
          ),
          Flexible(
            flex: 2,
            child: ValueBox(
              value: 20,
              textColor: 0xff0CECDD,
              backgroundColor: 0xff2A2831,
            ),
          )
        ],
      ),
    );
  }
}
