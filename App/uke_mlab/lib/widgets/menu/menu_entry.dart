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

    return Get.currentRoute != navigateTo
        ? ListTile(
            title: Text(
              name,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
            onTap: () => Get.toNamed(navigateTo))
        : ListTile(
            title: Text(
              name,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 20,
              ),
            ),
            onTap: null);
  }
}
