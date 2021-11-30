<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
=======
//
//just a widget to play with
import 'package:responsive_grid/responsive_grid.dart';

>>>>>>> 50ec0fe (#23 [TASK] add layout, theme, basic structure)
=======
>>>>>>> c429014 ([TASK]#23 Add Readme,And Example Project)
=======
>>>>>>> 4924591b61d571eee4862fb71aed813a92e32eed
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/screens/monitor.dart';
import 'package:uke_mlab/widgets/statusbar.dart';

<<<<<<< HEAD
<<<<<<< HEAD
import 'providers/mockup.dart';
=======
import 'package:uke_mlab/screens/monitor.dart';
>>>>>>> c429014 ([TASK]#23 Add Readme,And Example Project)
=======
import 'package:uke_mlab/screens/monitor.dart';
>>>>>>> 4924591b61d571eee4862fb71aed813a92e32eed

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
  ]).then((value) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
<<<<<<< HEAD
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
          page: () => Scaffold(
            appBar: AppBar(title: const StatusBar()),
            body: const Monitor(),
=======
    const Color containerColor = Color(0xff49454f);
    return MaterialApp(
        theme: ThemeData(
          scaffoldBackgroundColor: const Color(0xff1c1c1e),
          appBarTheme: const AppBarTheme(
            backgroundColor: Color.fromRGBO(29, 25, 43, 100),
>>>>>>> 4924591b61d571eee4862fb71aed813a92e32eed
          ),
          binding: MonitorBinding(),
        ),
<<<<<<< HEAD
      ],
      initialRoute: "/monitor",
=======
    const Color containerColor = Color(0xff49454f);
    return MaterialApp(
        theme: ThemeData(
          scaffoldBackgroundColor: const Color(0xff1c1c1e),
          appBarTheme: const AppBarTheme(
            backgroundColor: Color.fromRGBO(29, 25, 43, 100),
          ),
<<<<<<< HEAD
          body: View(containerColor: containerColor)),
>>>>>>> 50ec0fe (#23 [TASK] add layout, theme, basic structure)
    );
=======
        ),
=======
>>>>>>> 4924591b61d571eee4862fb71aed813a92e32eed
        title: 'Welcome to the UKE Mlab Team 123',
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Welcome to the UKE Mlab Team 123 0 0 0'),
          ),
          body: Monitor(),
        ));
<<<<<<< HEAD
>>>>>>> c429014 ([TASK]#23 Add Readme,And Example Project)
=======
>>>>>>> 4924591b61d571eee4862fb71aed813a92e32eed
  }
}
