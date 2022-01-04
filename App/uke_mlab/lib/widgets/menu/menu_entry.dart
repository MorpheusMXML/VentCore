import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppMenuEntry extends StatelessWidget {
  final String name;
  const AppMenuEntry({
    Key? key,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String navigateTo = '/' + name.replaceAll(RegExp(r' '), '_').toLowerCase();
    // TODO: Temp fix, Patient Settings = Start Screen?
    if (name == 'Patient Settings') {
      navigateTo = '/start_screen';
    }

    return Get.currentRoute != navigateTo
        ? ListTile(
            title: Text(
              name,
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
            onTap: () => Get.offNamed(navigateTo))
        : ListTile(
            title: Text(
              name,
              style: TextStyle(
                color: Theme.of(context).disabledColor,
                fontSize: 20,
              ),
            ),
            onTap: null);
  }
}
