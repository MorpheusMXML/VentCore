import 'package:flutter/material.dart';

class AppTheme {
  // TODO: Finish

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
