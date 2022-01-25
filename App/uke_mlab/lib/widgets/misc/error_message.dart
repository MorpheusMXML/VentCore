import 'package:flutter/material.dart';

// TODO: COMMENTARY
class ErrorMessage extends StatelessWidget {
  final FlutterErrorDetails details;
  const ErrorMessage({
    Key? key,
    required this.details,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.all(32),
      child: Text(
        'Error!\n\n${details.exception}',
        style: const TextStyle(color: Colors.blue, fontSize: 24),
        softWrap: true,
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      ),
    );
  }
}
