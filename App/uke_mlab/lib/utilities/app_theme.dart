import 'package:flutter/material.dart';

class AppTheme {
  // TODO: Finish; Replace every Colors.<color> with const (static) Colors
  // https://stackoverflow.com/questions/49172746
  // https://github.com/flutter/flutter/issues/31522
  // mixin example but without own fields: https://github.com/jogeanmcf/tetris_game/blob/8a6202f3f7ceb7d7c2d3e73d2dcdb4edb7f136cc/lib/theme.dart

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      fontFamily: 'Jura',
      scaffoldBackgroundColor: const Color(0xFF1C1C1E),
      appBarTheme: const AppBarTheme(backgroundColor: Color(0xFF1D192B)),
      cardColor: const Color(0xFF2A2831),
      shadowColor: const Color(0xFF49454F),
    );
  }

  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      fontFamily: 'Jura',
      scaffoldBackgroundColor: Colors.amber[50],
      appBarTheme: const AppBarTheme(backgroundColor: Color(0xFF1D192B)),
      cardColor: const Color(0xFF2A2831),
      shadowColor: const Color(0xFF49454F),
    );
  }
}
