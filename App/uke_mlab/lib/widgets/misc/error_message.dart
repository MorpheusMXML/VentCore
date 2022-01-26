import 'package:flutter/material.dart';
import 'package:uke_mlab/utilities/app_theme.dart';

/// Widget displaying an error message screen

/// {@category Widgets}
/// {@subCategory Miscellaneous}
class ErrorMessage extends StatelessWidget {
  final FlutterErrorDetails details;
  const ErrorMessage({
    Key? key,
    required this.details,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.all(32),
      child: Text(
        'Error!\n\n${details.exception}',
        style: theme.errorMessageTextStyle,
        softWrap: true,
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      ),
    );
  }
}
