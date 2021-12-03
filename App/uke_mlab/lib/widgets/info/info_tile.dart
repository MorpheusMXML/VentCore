import 'package:flutter/material.dart';
import 'package:uke_mlab/widgets/info/info_text.dart';

class InfoTile extends StatelessWidget {
  final List<Map<String, Object>> data;

  const InfoTile({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          padding: const EdgeInsets.only(top: 8, bottom: 8),
          child: InfoText(
            type: data[index]["type"].toString(),
            value: data[index]["value"].toString(),
            unit: data[index]["unit"].toString(),
          ),
        );
      },
    );
  }
}
