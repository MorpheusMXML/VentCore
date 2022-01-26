import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/models/system_state.dart';

/// This class provides the app with a two themes: [darkTheme] and [lightTheme].
/// By default, the app starts in the [lightTheme] and can be toggled to the [darkTheme] by clicking on the theme [ToggleThemeButton].
/// The class contains constant values (such as [heartFreqColor]) that are not changed when toggling the theme.
/// Text Styles, Button Styles and some Colors are changed depending on the active theme.
/// The theme class is extended by extensions that specify those styles.
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

  /// Dark theme of the App (default)
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

  /// Light theme of the App (experimental at the moment)
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

/// This extension contains custom colors that are used throughout the app.
/// The colors in [primarySwatch] are the most used colors.
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

/// This extension contains custom text styles that are used by certain widgets.
/// The colors in [primarySwatch] are the most used colors.
extension CustomTextStyles on ThemeData {
  /// Custom Text Styles for the app.

  // General TextStyles
  TextStyle get boldTextStyle => const TextStyle(
        fontWeight: FontWeight.bold,
      );

  TextStyle get navigationButtonTextStyle => const TextStyle(
        fontSize: 24,
      );

  TextStyle get mediumTextStyle => const TextStyle(
        fontSize: 24,
      );

  // TextStyles used by DetailsPopup.
  TextStyle get patientPopupTextStyle => TextStyle(
        fontSize: 21,
        fontWeight: FontWeight.bold,
        color: inverseContrastColor,
      );

  TextStyle get patientPopupTextStyle2 => TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: primarySwatch[10],
      );

  TextStyle get patientTypeTextStyle => const TextStyle(
        fontSize: 35,
        fontWeight: FontWeight.bold,
      );

// TextStyles used by GraphAdder.
  TextStyle get graphAdderPopupTextStyle => const TextStyle(
        fontSize: 18,
      );

  // TextStyles used by ErrorMessage.
  TextStyle get errorMessageTextStyle => const TextStyle(
        color: Colors.blue,
        fontSize: 24,
      );

  // TextStyles used by InfoText and InfoContainer.
  TextStyle get infoTextStyle => TextStyle(
        fontSize: 16,
        color: contrastColor,
      );

  // TextStyles used by Menu and MenuEntry.
  TextStyle get menuDisabledTextStyle => TextStyle(
        color: disabledColor,
        fontSize: 20,
      );

  TextStyle get menuTextStyle => const TextStyle(
        fontSize: 20,
      );

  TextStyle get menuHeadlineTextStyle => const TextStyle(
        fontSize: 28,
      );

  // TextStyles used by SettingContainer, SettingTile and SettingText
  TextStyle get settingTextStyle => TextStyle(
        fontSize: 16,
        color: contrastColor,
        fontWeight: FontWeight.bold,
      );

  TextStyle get settingTextStyle2 => TextStyle(
        fontSize: 24,
        color: contrastColor,
        fontWeight: FontWeight.bold,
      );

  TextStyle get settingTextStyle3 => TextStyle(
        fontSize: 16,
        color: contrastColor,
        fontWeight: FontWeight.bold,
      );

  // TextStyles used by AED Button
  TextStyle get aedButtonTextStyle => const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      );

  // TextStyles used by the graphs
  TextStyle get graphAlarmMessageTextStyle => TextStyle(
        color: inverseContrastColor,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      );

  // TextStyles used by AlarmCounterTile, AlarmFieldTile and StatusBar
  TextStyle get alarmTextStyle => TextStyle(
        color: inverseContrastColor,
        fontSize: 24,
      );

  TextStyle get alarmFieldTextStyle => TextStyle(
        color: inverseContrastColor,
        decoration: TextDecoration.none,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      );

  TextStyle get statusBarTextStyle => TextStyle(
        color: contrastColor,
        decoration: TextDecoration.none,
      );

  // TextStyles used by DefibrillationStats, SystemDiagnosis, ImpedanceContainer, ShockPower
  TextStyle get defiStatsHeadlineTextStyle => const TextStyle(
        fontSize: 18,
      );

  TextStyle get defiStatsValueTextStyle => const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
      );

  TextStyle get defiDiagnosisTextStyle => const TextStyle(
        fontSize: 20,
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

/// This extension contains custom button styles that are used by certain widgets.
/// The colors in [primarySwatch] are the most used colors.
extension CustomButtonStyles on ThemeData {
  // Buttonstyle used by ValueBoxContainer
  ButtonStyle get valueBoxContainerButtonStyle => ButtonStyle(
        shape: MaterialStateProperty.all(
          const RoundedRectangleBorder(),
        ),
        backgroundColor: MaterialStateProperty.all(
          primarySwatch[40],
        ),
      );

  // Buttonstyles used by DefibrillationButton, ImpedanceButton and SynchronicityButton
  ButtonStyle get defiRegularButtonStyle => ElevatedButton.styleFrom(
        primary: primarySwatch[40],
        onPrimary: contrastColor,
      );

  ButtonStyle get defiSelectedButtonStyle => ButtonStyle(
        side: MaterialStateProperty.all(const BorderSide(color: Colors.green)),
        foregroundColor: MaterialStateProperty.all(Colors.green),
      );

  // Buttonstyles used by ShockPower
  ButtonStyle get shockPowerButtonStyle => ElevatedButton.styleFrom(
        primary: Colors.transparent,
        textStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 100,
          color: Colors.red,
        ),
      );
}
