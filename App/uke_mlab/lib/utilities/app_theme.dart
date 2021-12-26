import 'package:flutter/material.dart';

const Color scaffoldBackgroundColor = Color(0xFF1C1C1E);
const Color appBarBackgroundColor = Color(0xFF1D192B);

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData.dark().copyWith(
        appBarTheme: const AppBarTheme(backgroundColor: appBarBackgroundColor),
        scaffoldBackgroundColor: scaffoldBackgroundColor,
        /*elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              fixedSize: const Size(200, 60),
              onSurface: const Color(0xffeeeeee),
              primary: const Color(0xffeeeeee),
              onPrimary: Colors.black,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(75))),
        ),*/
        cardColor: const Color(0xFF2A2831),
        shadowColor: const Color(0xFF49454F));
  }

  static ThemeData get lightTheme {
    return ThemeData.light().copyWith();
  }
}
