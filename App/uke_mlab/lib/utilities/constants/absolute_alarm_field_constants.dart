import 'package:get/get.dart';

//TODO: COMMENTARY
class AbsoluteAlarmFieldConst {
  static final double width = (Get.width - 24) / 3 - 8; // 12 padding, Graph(flex 2), AbsAlarmField(flex 1) Area 12 padding, 8 padding from elements
  static final double left = Get.width - width - 24 + 4;
  static final double heigthTotal = Get.height;

  static const double flexAbsValueTilesHeight = 8;
  static const double flexSizeIPPV = 13;
  static const double flexAlarmButtonsHeight = 3;

  static const int buttonHeight = 40;
  static const int toggleButtonHeightFactor = 2;

  static const double horizontalMargin = 8;
  static const double verticalMargin = 8;

  static final double ippvHeight =
      ((heigthTotal) / (2 * flexAbsValueTilesHeight + flexSizeIPPV + flexAlarmButtonsHeight) * flexSizeIPPV) - (toggleButtonHeightFactor * buttonHeight);
  static final double overlayPositionTop =
      ((heigthTotal) / (2 * flexAbsValueTilesHeight + flexSizeIPPV + flexAlarmButtonsHeight) * 2 * flexAbsValueTilesHeight) + 1;

  static final double alarmTileHeight = heigthTotal - (toggleButtonHeightFactor * buttonHeight) - ippvHeight - 3 * 8;
  static final double alarmTileWidth = width / 2;
}
