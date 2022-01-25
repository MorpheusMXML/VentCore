import 'package:flutter/material.dart';

/// A widget that formats ventilation information.
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
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Text(
              type,
              style: TextStyle(fontSize: 16, color: Theme.of(context).dividerColor),
            ),
          ),
          Text(
            value,
            style: TextStyle(fontSize: 16, color: Theme.of(context).dividerColor),
          ),
          Text(
            unit,
            style: TextStyle(fontSize: 10, color: Theme.of(context).dividerColor),
          ),
        ],
      ),
    );
  }
}
