import 'package:flutter/material.dart';

class AppTheme {
  // TODO: Finish; Replace every Colors.<color> with const (static) Colors
  // https://stackoverflow.com/questions/49172746
  // https://github.com/flutter/flutter/issues/31522
  // mixin example but without own fields: https://github.com/jogeanmcf/tetris_game/blob/8a6202f3f7ceb7d7c2d3e73d2dcdb4edb7f136cc/lib/theme.dart

  // Moved here from StyleController
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
  static const Color alarmWarningColor = Color(0xFF89AC76); //Color(0xFF49FF00);
  static const Color alarmNoneColor = Color(0xFF2A2831);
  static const Color alarmMessageColor = Color(0xFF000000);

  final Color backgroundColor = const Color(0xFF1C1B1F);
  final Color appBar = const Color(0xFF1d192B);

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      fontFamily: 'Jura',
      scaffoldBackgroundColor: const Color(0xFF1C1C1E),
      appBarTheme: const AppBarTheme(backgroundColor: Color(0xFF1D192B)),
      cardColor: const Color(0xFF2A2831),
      shadowColor: const Color(0xFF49454F),
      focusColor: const Color(0xFF25232A),
      dividerColor: const Color(0xFFFFFFFF),
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
      cardColor: Colors.amber[100],
      shadowColor: Colors.amber[300],
      focusColor: Colors.amber[200],
      dividerColor: const Color(0xFF000000),
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
