import 'package:flutter/material.dart';
import 'package:uke_mlab/utilities/app_theme.dart';
import 'package:uke_mlab/widgets/info/info_text.dart';

/// A widget that shows multiple [InfoText]'s.
///
/// {@category Info}
class InfoContainer extends StatelessWidget {
  final List<Map<String, Object>> data;

  const InfoContainer({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          color: theme.primarySwatch[80],
          padding: const EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 4),
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
