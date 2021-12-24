import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/providers/start_screen_controller.dart';
import 'package:uke_mlab/providers/toggle_controller.dart';
import 'package:uke_mlab/screens/demo_screen.dart';
import 'package:uke_mlab/screens/monitor.dart';
import 'package:uke_mlab/screens/start_screen.dart';
import 'package:uke_mlab/models/system_state.dart';
import 'package:uke_mlab/models/model_manager.dart';
import 'package:uke_mlab/utilities/alarm_controller.dart';
import 'package:uke_mlab/utilities/screen_controller.dart';
import 'package:uke_mlab/widgets/statusbar/statusbar.dart';

void main() {
  // We need to call it manually,
  // because we are going to call setPreferredOrientations()
  // before the runApp() call
  WidgetsFlutterBinding.ensureInitialized();

  // Then we setup preferred orientations,
  // and only after it finished we run our app
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeRight,
    DeviceOrientation.landscapeLeft,
  ]).then((value) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  final SystemState systemState = Get.put(SystemState());
  final ModelManager modelManager = Get.put(ModelManager());

  MyApp({Key? key}) : super(key: key) {
    // Create Binding Class for alarmcontroller and bind to the respective
    // pages, maybe create a new starting screen (loading screen) that navigates
    // to the current start page when all controllers are initialized, jsons,
    // svgs are loaded and screens are given bindings?
    final AlarmController alarmController =
        Get.put(AlarmController(modelManager));
  }

  @override
  Widget build(BuildContext context) {
    systemState.activateTimer();

    return GetMaterialApp(
      title: 'MLab UKE',
      // TODO: Custom theme
      theme: ThemeData(
          appBarTheme: const AppBarTheme(backgroundColor: Color(0xFF1D192B)),
          scaffoldBackgroundColor: const Color(0xFF1C1C1E),
          cardColor: const Color(0xFF2A2831),
          shadowColor: const Color(0xFF49454F)),
      getPages: [
        GetPage(
          name: "/monitor",
          page: () => getScaffold(Monitor()),
          bindings: [
            StartScreenBinding(),
            ToggleBinding(),
            ScreenBinding(),
          ],
        ),
        GetPage(
          name: "/start_screen",
          page: () => getScaffold(const StartScreen()),
          bindings: [
            StartScreenBinding(),
            ScreenBinding(),
          ],
        ),
        GetPage(
          name: "/demo_scenarios",
          page: () => getScaffold(const DemoScreen()),
          bindings: [
            StartScreenBinding(),
          ],
        )
      ],
      initialRoute: "/start_screen",
    );
  }

  Widget getScaffold(Widget screenWidget) {
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
        body: screenWidget);
  }
}
