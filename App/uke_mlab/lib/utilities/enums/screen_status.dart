import 'package:uke_mlab/screens/main_screen.dart';

/// Contains keys for each major screen configuration available.
///
/// This does not correlate directly to screens since some screens are minor (as setting screens)
/// While [patientSettingScreen], [monitorScreen] and [ventilationScreen] are realized via manipulating [MainScreen]
///
/// {@category Enums}
enum screenStatusEnum {
  patientSettingScreen,
  monitorScreen,
  ventilationScreen,
  defibrillationScreen,
}
