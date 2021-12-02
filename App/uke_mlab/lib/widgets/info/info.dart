import 'package:flutter/material.dart';
import 'package:uke_mlab/widgets/info/info_text.dart';

class Info extends StatelessWidget {
  final String type;
  final double value;
  final String unit;

  const Info({
    Key? key,
    required this.type,
    required this.value,
    required this.unit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
          decoration: const BoxDecoration(
            color: Color(0xFF2A2831),
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          margin: const EdgeInsets.all(8),
          child: Container(
              margin: const EdgeInsets.only(left: 12, right: 12),
              child: InfoText(type: type, value: value, unit: unit))),
    );
  }
}
