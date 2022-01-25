import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/models/system_state.dart';

//TODO: COMMENTARY
class AppTheme {
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
      Get.isDarkMode ? primarySwatch[0] : primarySwatch[100];
  Color? get inverseContrastColor =>
      Get.isDarkMode ? primarySwatch[100] : primarySwatch[0];
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

  TextStyle get alarmFieldTextStyle => TextStyle(
        color: inverseContrastColor,
        decoration: TextDecoration.none,
        fontSize: 18,
        fontWeight: FontWeight.w300,
      );

  TextStyle get alarmTextStyle => TextStyle(
        color: inverseContrastColor,
        fontSize: 24,
      );

  TextStyle get statusBarTextStyle => TextStyle(
        color: contrastColor,
        decoration: TextDecoration.none,
      );

  TextStyle get defiStatsHeadlineTextStyle => const TextStyle(
        fontSize: 18,
      );

  TextStyle get defiStatsValueTextStyle => const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
      );

  TextStyle get impedanceTextStyle => TextStyle(
        color: contrastColor,
      );

  TextStyle get shockPowerTextStyle => const TextStyle(
        fontSize: 24,
      );

  TextStyle get shockPowerButtonTextStyle => const TextStyle(
        fontFamily: 'Jura',
        fontWeight: FontWeight.bold,
        fontSize: 32,
        color: Colors.red,
      );

  TextStyle get jouleTextStyle => const TextStyle(
        fontSize: 20,
        color: Colors.red,
      );
}

extension CustomButtonStyles on ThemeData {
  ButtonStyle get alarmCounterButtonStyle => ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
            Get.find<SystemState>().generalAlarms.alarmList[0].toColor()),
        shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(40))),
      );

  ButtonStyle get alarmFieldButtonStyle => ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        primary: AppTheme.alarmNoneColor,
        onPrimary: contrastColor,
      );

  ButtonStyle get defiRegularButtonStyle => ElevatedButton.styleFrom(
        primary: primarySwatch[40],
        onPrimary: contrastColor,
      );

  ButtonStyle get defiSelectedButtonStyle => ButtonStyle(
        side: MaterialStateProperty.all(const BorderSide(color: Colors.green)),
        foregroundColor: MaterialStateProperty.all(Colors.green),
      );

  ButtonStyle get shockPowerButtonStyle => ElevatedButton.styleFrom(
      primary: Colors.transparent,
      textStyle: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 100,
        color: Colors.red,
      ));
}
