import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/providers/screen_controller.dart';
import 'package:uke_mlab/utilities/app_theme.dart';
import 'package:uke_mlab/widgets/menu/menu_entry.dart';
import 'package:uke_mlab/widgets/menu/toggle_theme_button.dart';

/// Contains the drawer for the menu Button
///
/// {@category Menu}
class AppMenu extends StatelessWidget {
  const AppMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    Get.find<ScreenController>().hideAlarmBoundaryOverlays();

    List<String> routes = [
      'Start Screen',
      'Alarm Limit Screen',
      'Demo Screen',
    ];

    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Menu', style: theme.menuHeadlineTextStyle),
                  const ToggleThemeButton()
                ]),
          ),
          ...routes.map((entry) => AppMenuEntry(name: entry)).toList(),
        ],
      ),
    );
  }
}
