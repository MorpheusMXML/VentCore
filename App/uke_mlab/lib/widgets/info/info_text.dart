import 'package:flutter/material.dart';
import 'package:uke_mlab/utilities/app_theme.dart';

/// A widget that formats ventilation information.
/// {@category Widgets}
/// {@subCategory Info}
class InfoText extends StatelessWidget {
  final String type;
  final String value;
  final String unit;

  const InfoText({
    Key? key,
    required this.type,
    required this.value,
    required this.unit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.primarySwatch[40],
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Text(
              type,
              style: theme.infoTextStyle,
            ),
          ),
          Text(
            value,
            style: theme.infoTextStyle,
          ),
          Text(
            unit,
            style: theme.infoTextStyle,
          ),
        ],
      ),
    );
  }
}
