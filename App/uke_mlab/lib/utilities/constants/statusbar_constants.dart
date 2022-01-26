import 'package:get/get.dart';
import 'package:uke_mlab/utilities/enums/patient_type.dart';
import 'package:uke_mlab/widgets/appbar/alarm_counter_tile.dart';
import 'package:uke_mlab/widgets/appbar/alarm_field_tile.dart';
import 'package:uke_mlab/widgets/appbar/alarm_list.dart';
import 'package:uke_mlab/widgets/appbar/statusbar.dart';

/// Contains constants relating the [StatusBar].
/// {@category Utilities}
/// {@subCategory Constants}
class StatusBarConstants {
  /// Flex value for the [AlarmCounterTile].
  static const int flexBarAlarmCounterTile = 4;

  /// Flex value for the [AlarmFieldTile].
  static const int flexBarAlarmFieldTile = 8;

  /// Flex value for the alarm area (consisting of [AlarmFieldTile] and [AlarmCounterTile]).
  static const int flexBarAlarmArea = 5;

  /// Flex value for the O2 Bottle area.
  static const int flexBarO2BottleArea = 1;

  /// Flex value for part displaying the [patientTypeEnum].
  static const int flexBarPatientTypeArea = 1;

  /// Flex value for part displaying the button to mute alarms.
  static const int flexMuteECGButtonArea = 1;

  /// Horizontal default margin.
  static const double horizontalMargin = 8;

  /// Vertical default margin.
  static const double verticalMargin = 8;

  /// Width of the menu button
  static const double menuButtonWidth = 56; // according to stackoverflow this is the default

  /// Width for the [AlarmList]
  static final double alarmListWidth = (((Get.width - menuButtonWidth) /
              (flexBarAlarmArea + flexBarO2BottleArea + flexBarPatientTypeArea + flexMuteECGButtonArea)) *
          flexBarAlarmArea /
          (flexBarAlarmCounterTile + flexBarAlarmFieldTile) *
          flexBarAlarmFieldTile) -
      horizontalMargin;
}
