import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/providers/sound_controller.dart';

import 'package:uke_mlab/screens/alarm_limit_screen.dart';
import 'package:uke_mlab/screens/demo_screen.dart';
import 'package:uke_mlab/screens/main_screen.dart';
import 'package:uke_mlab/screens/start_screen.dart';
import 'package:uke_mlab/models/system_state.dart';
import 'package:uke_mlab/models/data_models/model_manager.dart';
import 'package:uke_mlab/providers/alarm_controller.dart';
import 'package:uke_mlab/utilities/app_theme.dart';
import 'package:uke_mlab/utilities/controller_bindings.dart';
import 'package:uke_mlab/widgets/misc/app_scaffold.dart';
import 'package:uke_mlab/widgets/misc/error_message.dart';

void main() {
  // Set the ErrorWidget's builder before the app is started.
  ErrorWidget.builder = (FlutterErrorDetails details) {
    return ErrorMessage(details: details);
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
  final SoundController soundController = Get.put(SoundController());

  MyApp({Key? key}) : super(key: key) {
    // TODO: Create Binding Class for AlarmController and bind to the respective
    // pages, maybe create a new starting screen (loading screen) that navigates
    // to the current start page when all controllers are initialized, jsons,
    // svgs are loaded and screens are given bindings?
    final AlarmController alarmController =
        Get.put(AlarmController(modelManager));
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'MLab UKE',
      theme: AppTheme.darkTheme,
      getPages: [
        GetPage(
          name: '/main_screen',
          page: () => AppScaffold(screen: MainScreen()),
        ),
        GetPage(
          name: '/start_screen',
          page: () => const AppScaffold(screen: StartScreen()),
        ),
        GetPage(
          name: '/demo_screen',
          page: () => const AppScaffold(screen: DemoScreen()),
        ),
        GetPage(
          name: '/alarm_limit_screen',
          page: () => const AppScaffold(screen: AlarmLimitScreen()),
        )
      ],
      initialBinding: ControllerBindings(),
      initialRoute: '/start_screen',
    );
  }
}
