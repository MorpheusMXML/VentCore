import 'package:flutter/material.dart';
import 'package:uke_mlab/widgets/menu/menu_entry.dart';

class AppMenu extends StatelessWidget {
  const AppMenu({Key? key}) : super(key: key);

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
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.grey,
            ),
            child: Text('Menu', style: TextStyle(fontSize: 28)),
          ),
          ...routes.map((entry) => AppMenuEntry(name: entry)).toList()
        ],
      ),
    );
  }
}
