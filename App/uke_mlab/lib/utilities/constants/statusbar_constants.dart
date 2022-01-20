import 'package:get/get.dart';

class StatusBarConstants {
  static const int flexBarAlarmCounterTile = 4;
  static const int flexBarAlarmFieldTile = 8;

  static const int flexBarAlarmArea = 5;
  static const int flexBarO2BottleArea = 1;
  static const int flexBarPatientTypeArea = 1;

  static const double horizontalMargin = 8;
  static const double verticalMargin = 8;

  static const double menuButtonWidth =
      56; // according to stackoverflow this is the default

  static final double alarmListWidth = (((Get.width - menuButtonWidth) /
              (flexBarAlarmArea +
                  flexBarO2BottleArea +
                  flexBarPatientTypeArea)) *
          flexBarAlarmArea /
          (flexBarAlarmCounterTile + flexBarAlarmFieldTile) *
          flexBarAlarmFieldTile) -
      horizontalMargin;
}
