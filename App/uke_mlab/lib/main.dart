import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uke_mlab/models/model.dart';

import 'package:uke_mlab/screens/monitor.dart';
import 'package:uke_mlab/utilities/alarm_controller.dart';
import 'package:uke_mlab/utilities/screen_controller.dart';

import 'package:get/get.dart';

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
  final ModelManager modelManager = Get.put(ModelManager());

  MyApp({Key? key}) : super(key: key) {
    final AlarmController alarmController =
        Get.put(AlarmController(modelManager));
    final ScreenController screenController = Get.put(ScreenController());
  }

  @override
  Widget build(BuildContext context) {
    const Color containerColor = Color(0xff49454f);
    return MaterialApp(
        theme: ThemeData(
          scaffoldBackgroundColor: const Color(0xff1c1c1e),
          appBarTheme: const AppBarTheme(
            backgroundColor: Color.fromRGBO(29, 25, 43, 100),
          ),
        ),
        title: 'Welcome to the UKE Mlab Team 123',
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Welcome to the UKE Mlab Team 123 0 0 0'),
          ),
          body: Monitor(),
        ));
  }
}
