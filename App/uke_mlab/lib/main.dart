import 'dart:js';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/screens/alarm_limit_screen.dart';
import 'package:uke_mlab/providers/start_screen_controller.dart';
import 'package:uke_mlab/providers/toggle_controller.dart';
import 'package:uke_mlab/screens/demo_screen.dart';
import 'package:uke_mlab/screens/main_screen.dart';
import 'package:uke_mlab/screens/start_screen.dart';
import 'package:uke_mlab/models/system_state.dart';
import 'package:uke_mlab/models/model_manager.dart';
import 'package:uke_mlab/utilities/alarm_controller.dart';
import 'package:uke_mlab/utilities/app_theme.dart';
import 'package:uke_mlab/utilities/screen_controller.dart';
import 'package:uke_mlab/widgets/appbar/statusbar.dart';
import 'package:uke_mlab/widgets/menu/menu.dart';

void main() {
  // Set the ErrorWidget's builder before the app is started.
  ErrorWidget.builder = (FlutterErrorDetails details) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.all(32),
      child: Text(
        'Error!\n\n${details.exception}',
        style: const TextStyle(color: Colors.blue, fontSize: 24),
        softWrap: true,
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      ),
    );
  };

  WidgetsFlutterBinding.ensureInitialized();

  // Start the app.
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeRight,
    DeviceOrientation.landscapeLeft,
  ]).then((value) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  final SystemState systemState = Get.put(SystemState());
  final ModelManager modelManager = Get.put(ModelManager());

  MyApp({Key? key}) : super(key: key) {
    // TODO: Create Binding Class for AlarmController and bind to the respective
    // pages, maybe create a new starting screen (loading screen) that navigates
    // to the current start page when all controllers are initialized, jsons,
    // svgs are loaded and screens are given bindings?
    // TODO: Look into InitialBinding
    final AlarmController alarmController =
        Get.put(AlarmController(modelManager));
  }

  @override
  Widget build(BuildContext context) {
    systemState.activateTimer();

    return GetMaterialApp(
      title: 'MLab UKE',
      // TODO: Replace every Colors.<color> with const (static) Colors
      theme: AppTheme.darkTheme,
      getPages: [
        GetPage(
          name: '/main_screen',
          page: () => AppScaffold(screen: MainScreen()),
          bindings: [
            StartScreenBinding(),
            ToggleBinding(),
            ScreenBinding(),
          ],
        ),
        GetPage(
          name: '/start_screen',
          page: () => const AppScaffold(screen: StartScreen()),
          bindings: [
            ToggleBinding(),
            StartScreenBinding(),
            ScreenBinding(),
          ],
        ),
        GetPage(
          name: '/demo_screen',
          page: () => const AppScaffold(screen: DemoScreen()),
          bindings: [
            StartScreenBinding(),
          ],
        ),
        GetPage(
          name: '/alarm_limit_screen',
          page: () => const AppScaffold(screen: AlarmLimitScreen()),
          bindings: [
            StartScreenBinding(),
          ],
        )
      ],
      initialRoute: '/start_screen',
    );
  }
}

class AppScaffold extends StatelessWidget {
  final Widget screen;

  const AppScaffold({
    Key? key,
    required this.screen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const AppMenu(),
        appBar: AppBar(title: const StatusBar()),
        body: screen);
  }
}
