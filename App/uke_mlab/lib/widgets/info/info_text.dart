import 'package:flutter/material.dart';

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
      decoration: const BoxDecoration(
        color: Color(0xFF2A2831),
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              type,
              style: const TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
          Text(
            value.toString(),
            style: const TextStyle(fontSize: 16, color: Colors.white),
          ),
          Text(
            unit,
            style: const TextStyle(fontSize: 10, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
