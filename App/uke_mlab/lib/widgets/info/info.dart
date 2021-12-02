import 'package:flutter/material.dart';
import 'package:uke_mlab/widgets/info/info_text.dart';

class Info extends StatelessWidget {
  final List<Map<String, Object>> data;

  const Info({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF25232A),
      ),
      child: Container(
        margin: const EdgeInsets.only(left: 12, right: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: data.map((e) {
            return InfoText(
                type: e["type"].toString(),
                value: e["value"].toString(),
                unit: e["unit"].toString());
          }).toList(),
        ),
      ),
    );
  }
}
