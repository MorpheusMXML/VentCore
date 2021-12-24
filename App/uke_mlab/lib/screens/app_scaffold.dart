import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/widgets/statusbar/statusbar.dart';

class AppScaffold extends StatelessWidget {
  final Widget screen;

  const AppScaffold({
    Key? key,
    required this.screen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
          child: ListView(
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text('Menu'),
              ),
              ListTile(
                title: const Text('Patient Settings'),
                onTap: Get.currentRoute != "/patient_settings"
                    ? () => Get.toNamed("/patient_settings")
                    : null,
              ),
              ListTile(
                title: const Text('Alarm Limits'),
                onTap: Get.currentRoute != "/alarm_limits"
                    ? () => Get.toNamed("/alarm_limits")
                    : null,
              ),
              ListTile(
                title: const Text('Demo Scenarios'),
                onTap: Get.currentRoute != "/demo_scenarios"
                    ? () => Get.toNamed("/demo_scenarios")
                    : null,
              ),
            ],
          ),
        ),
        appBar: AppBar(title: const StatusBar()),
        body: screen);
  }
}
