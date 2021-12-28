import 'package:flutter/material.dart';
import 'package:uke_mlab/widgets/menu/menu_entry.dart';
import 'package:uke_mlab/widgets/menu/toggle_theme_button.dart';

class AppMenu extends StatelessWidget {
  const AppMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> routes = [
      'Patient Settings',
      'Alarm Limit Screen',
      'Demo Screen',
    ];

    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text('Menu', style: TextStyle(fontSize: 28)),
                  ToggleThemeButton()
                ]),
          ),
          ...routes.map((entry) => AppMenuEntry(name: entry)).toList(),
        ],
      ),
    );
  }
}
