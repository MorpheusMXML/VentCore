import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/models/system_state.dart';
import 'package:uke_mlab/utilities/app_theme.dart';

/// This class represents a single Toggle Mode Button.
/// The buttons are used by the [ToggleModeButtonContainer].
/// The toggling logic is implemented by [ToggleModeButtonContainer] which utilizes [SystemState].
///
/// {@category Toggle}
class ToggleModeButton extends StatelessWidget {
  /// A single button for toggling the mode.
  final int index;
  final String path;

  const ToggleModeButton({
    Key? key,
    required this.path,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final SystemState systemState = Get.find<SystemState>();

    return Container(
      decoration: BoxDecoration(
          color: systemState.selectedToggleView[index]
              ? theme.primarySwatch[90]
              : theme.primarySwatch[70]),
      width: 100,
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: SvgPicture.asset(
          path,
          height: 40.0,
          color: systemState.selectedToggleView[index]
              ? theme.contrastColor
              : theme.primarySwatch[30],
        ),
      ),
    );
  }
}
