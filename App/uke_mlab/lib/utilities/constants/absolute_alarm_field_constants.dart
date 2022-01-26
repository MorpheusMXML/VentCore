import 'package:get/get.dart';
import 'package:uke_mlab/models/screen_element_models/ippv_model.dart';
import 'package:uke_mlab/widgets/value_box/alarm_confirmation/alarm_confirmation_button_row.dart';
import 'package:uke_mlab/widgets/value_box/value_box_tile.dart';

/// Contains static constants for the right part of the screen, containing the non graph based alarm fields.
class AbsoluteAlarmFieldConst {
  /// Total width of the screen part (excluding padding)
  static final double width = (Get.width - 24) / 3 -
      8; // 12 padding, Graph(flex 2), AbsAlarmField(flex 1) Area 12 padding, 8 padding from elements
  /// left padding of elements
  static final double left = Get.width - width - 24 + 4;

  /// Total height of the screen part (excluding padding)
  static final double heigthTotal = Get.height;

  /// Flex value for the [ValueBoxTile] part of the absolute field screen part
  static const double flexAbsValueTilesHeight = 8;

  /// Flex value for the [IppvModel] part of the absolute field screen part
  static const double flexSizeIPPV = 13;

  /// Flex value for the [AlarmConfirmationRow] part of the absolute field screen part
  static const double flexAlarmButtonsHeight = 3;

  /// Standard button height
  static const int buttonHeight = 40;

  /// Standard button height factor
  static const int toggleButtonHeightFactor = 2;

  /// Standard button height factor
  static const double horizontalMargin = 8;

  /// Standard button height factor
  static const double verticalMargin = 8;

  /// Height of the IPPv component
  static final double ippvHeight = ((heigthTotal) /
          (2 * flexAbsValueTilesHeight +
              flexSizeIPPV +
              flexAlarmButtonsHeight) *
          flexSizeIPPV) -
      (toggleButtonHeightFactor * buttonHeight);

  /// Starting point for the overlay to confirm alarms
  static final double overlayPositionTop = ((heigthTotal) /
          (2 * flexAbsValueTilesHeight +
              flexSizeIPPV +
              flexAlarmButtonsHeight) *
          2 *
          flexAbsValueTilesHeight) +
      1;

  /// Height of a single alarm tile
  static final double alarmTileHeight = heigthTotal -
      (toggleButtonHeightFactor * buttonHeight) -
      ippvHeight -
      3 * 8;

  /// Width of a single alarm tile
  static final double alarmTileWidth = width / 2;
}
