//
//just a widget to play with
import 'package:responsive_grid/responsive_grid.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:uke_mlab/src/controller.dart';
import 'package:uke_mlab/src/model.dart';
import 'package:uke_mlab/src/view.dart';

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
      title: 'Welcome to the UKE Mlab Team',
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Welcome to the UKE Mlab Team'),
          ),
          body: View(containerColor: containerColor)),
    );
  }
}
