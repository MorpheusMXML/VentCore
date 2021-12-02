import 'package:flutter/material.dart';
import 'package:uke_mlab/widgets/info/info.dart';

class InfoTile extends StatelessWidget {
  const InfoTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: const [
          Info(type: "pPeak", value: 50.12, unit: "mBar"),
          Info(type: "pPlat", value: 4.58, unit: "mBar"),
          Info(type: "pMean", value: 16.58, unit: "mBar"),
          Info(type: "MV", value: 7.2, unit: "l/min"),
        ],
      ),
    );
  }
}
