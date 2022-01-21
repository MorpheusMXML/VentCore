import 'package:get/get.dart';

//TODO: Apply to the various instances
class AbsoluteAlarmFieldConst {
  static final double width = (Get.width - 24) / 3 -
      8; // 12 padding, Graph(flex 2), AbsAlarmField(flex 1) Area 12 padding, 8 padding from elements
  static final double left = Get.width - width - 24 + 4;
  static final double heigthTotal =
      Get.height; // -MediaQuery.of(context).padding.top;

  static const double flexAbsValueTilesHeight = 8;
  static const double flexSizeIPPV = 13;
  static const double flexAlarmButtonsHeight = 3;

  static const int buttonHeight = 40;
  static const int toggleButtonHeightFactor = 2;

  static const double horizontalMargin = 8;
  static const double verticalMargin = 8;

  static final double ippvHeight = ((heigthTotal) /
          (2 * flexAbsValueTilesHeight +
              flexSizeIPPV +
              flexAlarmButtonsHeight) *
          flexSizeIPPV) -
      (toggleButtonHeightFactor * buttonHeight);
  static final double overlayPositionTop = ((heigthTotal) /
          (2 * flexAbsValueTilesHeight +
              flexSizeIPPV +
              flexAlarmButtonsHeight) *
          2 *
          flexAbsValueTilesHeight) +
      1; // + MediaQuery.of(context).padding.top;?
  // WTF? That shouldnt work in my book since height of statusbar and togglebutton heigth are not looked at, but hey...

  static final double alarmTileHeight = heigthTotal -
      (toggleButtonHeightFactor * buttonHeight) -
      ippvHeight -
      3 * 8;
  static final double alarmTileWidth = width / 2;
}
