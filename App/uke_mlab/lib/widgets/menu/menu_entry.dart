import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/providers/screen_controller.dart';

class AppMenuEntry extends StatelessWidget {
  final String name;
  const AppMenuEntry({
    Key? key,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ScreenController screenController = Get.find<ScreenController>();
    String navigateTo = '/' + name.replaceAll(RegExp(r' '), '_').toLowerCase();

    return Get.currentRoute != navigateTo
        ? ListTile(
            title: Text(
              name,
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
            onTap: () {
              switch (name) {
                case 'Start Screen':
                  screenController.patientSettingButton();
                  break;
                case 'Demo Screen':
                  screenController.demoScreenButton();
                  break;
                case 'Alarm Limit Screen':
                  screenController.alarmSettingsButton();
                  break;
              }
            })
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
