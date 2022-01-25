import 'package:flutter/material.dart';
import 'package:get/get.dart';

//TODO: COMMENTARY
class AppTheme {
  static bool isDark = Get.isDarkMode;

  static const Color heartFreqColor = Color(0xFF34C759);
  static const Color flowColor = Color(0xFF0CECDD);
  static const Color mveColor = Color(0xFFFFEE58);
  static const Color plethColor = Color(0xFF007AFF);
  static const Color co2Color = Color(0xFFAf52DE);
  static const Color pulseColor = Color(0xFFFF00E4);
  static const Color pawColor = Color(0xFFEF5DA8);
  static const Color tempColor = Color(0xFFFF6482);
  static const Color nibdColor = Color(0xFFDC362E);
  static const Color breathFrequencyColor = Color(0xFF009688);
  static const Color alarmHighColor = Color(0xFFFF0000);
  static const Color alarmMiddleColor = Color(0xFFFBFF00);
  static const Color alarmWarningColor = Color(0xFF34C759);
  static const Color alarmNoneColor = Color(0xFF1C1C1E);
  static const Color alarmMessageColor = Color(0xFF000000);

  final Color backgroundColor = const Color(0xFF1C1B1F);
  final Color appBar = const Color(0xFF1d192B);

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      fontFamily: 'Jura',
      scaffoldBackgroundColor: const Color(0xFF1C1C1E),
      appBarTheme: const AppBarTheme(backgroundColor: Color(0xFF1D192B)),
      toggleButtonsTheme: ToggleButtonsThemeData(
        borderColor: Colors.grey[800],
        borderWidth: 0.5,
        selectedBorderColor: const Color(0xFFFFFFFF),
        borderRadius: const BorderRadius.all(
          Radius.circular(25),
        ),
      ),
    );
  }

  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      fontFamily: 'Jura',
      scaffoldBackgroundColor: Colors.amber[50],
      appBarTheme: AppBarTheme(backgroundColor: Colors.amber[400]),
      toggleButtonsTheme: ToggleButtonsThemeData(
        borderColor: Colors.grey[800],
        borderWidth: 0.5,
        selectedBorderColor: const Color(0xFF000000),
        borderRadius: const BorderRadius.all(
          Radius.circular(25),
        ),
      ),
    );
  }
}

// COLORS
extension CustomColors on ThemeData {
  ColorSwatch<int> get primarySwatch => ColorSwatch(0xFFEEEEEE, {
        0: Get.isDarkMode ? const Color(0xFFFFFFFF) : const Color(0xFFFFFFFF),
        10: Get.isDarkMode ? const Color(0xFFEEEEEE) : const Color(0x6FFFFFFF),
        20: Get.isDarkMode ? const Color(0xFF49454F) : const Color(0xDFFFFFFF),
        30: Get.isDarkMode ? const Color(0xFF322F37) : const Color(0xEFFFFFFF),
        40: Get.isDarkMode ? const Color(0xFF2A2831) : const Color(0xCFFFFFFF),
        50: Get.isDarkMode ? const Color(0xFF25232A) : const Color(0xBFFFFFFF),
        100: Get.isDarkMode ? const Color(0xFF000000) : const Color(0xAFFFFFFF),
      });

  Color? get contrastColor =>
      Get.isDarkMode ? primarySwatch[10] : primarySwatch[50];
  Color? get inverseContrastColor =>
      Get.isDarkMode ? primarySwatch[50] : primarySwatch[10];
}

// TEXT STYLES
extension CustomTextStyles on ThemeData {
  // TODO: Use these?
  static const xxs = 12;
  static const xs = 16;
  static const s = 17;
  static const m = 18;
  static const l = 20;
  static const xl = 24;
  static const xxl = 32;
  static const xxxl = 44;

  TextStyle get alarmTextStyle => const TextStyle(
        color: Colors.black,
        fontSize: 24,
      );

  TextStyle get statsHeadlineStyle => const TextStyle(
        fontSize: 18,
      );

  TextStyle get statsValueStyle => const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
      );

  TextStyle get defiDiagnosisTextStyle => const TextStyle(
        fontSize: 20,
      );

  TextStyle get patientPopupTextStyle => TextStyle(
        fontSize: 20,
        color: primarySwatch[50],
      );

  TextStyle get settingLabelTextStyle => TextStyle(
        fontSize: 16,
        color: contrastColor,
      );

  TextStyle get settingValueTextStyle => TextStyle(
        fontSize: 32,
        color: contrastColor,
      );

  TextStyle get settingUnitTextStyle => TextStyle(
        fontSize: 12,
        color: contrastColor,
      );

  TextStyle get infoTextStyle => TextStyle(
        fontSize: 20,
        color: contrastColor,
      );

  TextStyle get infoTextStyle2 => TextStyle(
        fontSize: 16,
        color: contrastColor,
      );

  TextStyle getValueBoxTopStyle(dataModelAbsolute) {
    return TextStyle(color: dataModelAbsolute.color, fontSize: 17);
  }

  TextStyle getValueBoxMiddleStyle(dataModelAbsolute) {
    return TextStyle(color: dataModelAbsolute.color, fontSize: 44);
  }

  TextStyle getValueBoxBottomStyle(dataModelAbsolute) {
    return TextStyle(color: dataModelAbsolute.color, fontSize: 17);
  }

  TextStyle getValueBoxHeadlineTextStyle(dataModel) {
    return TextStyle(
      decoration: TextDecoration.none,
      color: dataModel.color,
      fontSize: 20,
      overflow: TextOverflow.ellipsis,
    );
  }

  TextStyle get popupUnitTextStyle => TextStyle(color: inverseContrastColor);
  TextStyle get valueBoxSettingsTextStyle => TextStyle(
        fontSize: 12,
        color: contrastColor,
        decoration: TextDecoration.none,
      );
}

/*
// BUTTON STYLES
extension CustomButtonStyles on ThemeData {
  ButtonStyle get selectedPatientButtonStyle => ElevatedButton.styleFrom(
        textStyle: const TextStyle(fontSize: 24, fontFamily: 'Jura'),
        primary: const Color(0xFF808B96),
        onPrimary: Colors.black,
        fixedSize: Size(DeviceConstants.patientButtonWidth,
            DeviceConstants.patientButtonHeight),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(75)),
      );

  ButtonStyle get regularPatientButtonStyle => ElevatedButton.styleFrom(
        textStyle: const TextStyle(fontSize: 24, fontFamily: 'Jura'),
        primary: const Color(0xFFEEEEEE),
        onPrimary: Colors.black,
        fixedSize: Size(DeviceConstants.patientButtonWidth,
            DeviceConstants.patientButtonHeight),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(75)),
      );

  ButtonStyle get navigationButtonStyle => ElevatedButton.styleFrom(
        fixedSize: Size(DeviceConstants.navigationButtonWidth,
            DeviceConstants.navigationButtonHeight),
        onSurface: const Color(0xffeeeeee),
        primary: const Color(0xffeeeeee),
        onPrimary: Colors.black,
        textStyle: const TextStyle(fontSize: 20, fontFamily: 'Jura'),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(75)),
      );

  ButtonStyle get aedButtonStyle => ElevatedButton.styleFrom(
        fixedSize: Size(
            DeviceConstants.aedButtonWidth, DeviceConstants.aedButtonHeight),
        primary: const Color(0xff363638),
        onPrimary: const Color(0xff34c759),
        textStyle: const TextStyle(fontSize: 24, fontFamily: 'Jura'),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      );

  ButtonStyle get graphAlarmConfirmButtonStyle => ElevatedButton.styleFrom(
        fixedSize: Size(DeviceConstants.graphAlarmBorderConfirmWidth,
            DeviceConstants.graphAlarmBorderConfirmHeight),
        primary: primarySwatch[10],
        onPrimary: contrastColor,
        textStyle: const TextStyle(fontSize: 24, fontFamily: 'Jura'),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
      );

  ButtonStyle get regularDefiButton => ElevatedButton.styleFrom(
      fixedSize: Size(
          DeviceConstants.defiButtonWidth, DeviceConstants.defiButtonHeight),
      primary: primarySwatch[40],
      onPrimary: contrastColor);

  ButtonStyle get selectedDefiButton => ButtonStyle(
        fixedSize: MaterialStateProperty.all(Size(
            DeviceConstants.defiButtonWidth, DeviceConstants.defiButtonHeight)),
        side: MaterialStateProperty.all(const BorderSide(color: Colors.green)),
        foregroundColor: MaterialStateProperty.all(Colors.green),
      );

  ButtonStyle get clickableValueBoxStyle => ButtonStyle(
      fixedSize: MaterialStateProperty.all(
          Size(DeviceConstants.valueBoxWidth, DeviceConstants.valueBoxHeight)),
      shape: MaterialStateProperty.all(const RoundedRectangleBorder()),
      backgroundColor: MaterialStateProperty.all(primarySwatch[40]));

  ButtonStyle get alarmCounterButtonStyle => ButtonStyle(
      backgroundColor: MaterialStateProperty.all(
          Get.find<SystemState>().generalAlarms.alarmList.isNotEmpty
              ? Get.find<SystemState>().generalAlarms.alarmList[0].toColor()
              : Colors.transparent),
      shape: MaterialStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(40))));
}

// PADDING, MARGIN & CONTAINER DECORATION
extension CustomPaddings on ThemeData {
  EdgeInsets get infoTextPadding => const EdgeInsets.only(bottom: 4);
  EdgeInsets get infoElementPadding => const EdgeInsets.all(4);
  EdgeInsets get defiPadding => const EdgeInsets.only(bottom: 2, top: 2);

  EdgeInsets get aedButtonPadding =>
      EdgeInsets.only(left: DeviceConstants.aedButtonPadding);

  EdgeInsets get graphAlarmBorderPadding =>
      EdgeInsets.only(bottom: DeviceConstants.graphAlarmBorderPadding);

  EdgeInsets get graphAlarmMessagePadding =>
      EdgeInsets.only(top: DeviceConstants.graphAlarmMessagePadding);

  EdgeInsets get placeholderPadding =>
      EdgeInsets.all(DeviceConstants.placeholderPadding);

  BoxDecoration get popupUnitDecoration => BoxDecoration(
      color: contrastColor,
      borderRadius: const BorderRadius.all(Radius.circular(3)));
}*/

