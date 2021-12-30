import 'package:flutter/material.dart';
import 'package:uke_mlab/widgets/info/info_text.dart';

class InfoContainer extends StatelessWidget {
  final List<Map<String, Object>> data;

  const InfoContainer({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          color: const Color(0xFF25232A),
          padding: const EdgeInsets.all(8),
          margin: const EdgeInsets.only(right: 8),
          child: InfoText(
            type: data[index]['type'].toString(),
            value: data[index]['value'].toString(),
            unit: data[index]['unit'].toString(),
          ),
        );
      },
    );
  }
}
