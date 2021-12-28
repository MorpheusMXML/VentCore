import 'package:flutter/material.dart';

const Color scaffoldBackgroundColor = Color(0xFF1C1C1E);
const Color appBarBackgroundColor = Color(0xFF1D192B);

class AppTheme {
  static ThemeData get darkTheme {
    ThemeData(fontFamily: 'Jura');
    return ThemeData.dark().copyWith(
        textTheme: const TextTheme(
          bodyText1: TextStyle(fontFamily: 'Jura'),
          bodyText2: TextStyle(fontFamily: 'Jura'),
          button: TextStyle(fontFamily: 'Jura'),
          caption: TextStyle(fontFamily: 'Jura'),
          headline1: TextStyle(fontFamily: 'Jura'),
          headline2: TextStyle(fontFamily: 'Jura'),
          headline3: TextStyle(fontFamily: 'Jura'),
          headline4: TextStyle(fontFamily: 'Jura'),
          headline5: TextStyle(fontFamily: 'Jura'),
          headline6: TextStyle(fontFamily: 'Jura'),
          overline: TextStyle(fontFamily: 'Jura'),
          subtitle1: TextStyle(fontFamily: 'Jura'),
          subtitle2: TextStyle(fontFamily: 'Jura'),
        ),
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
    return ThemeData.light().copyWith(
        textTheme: const TextTheme(
      bodyText1: TextStyle(fontFamily: 'Jura'),
      bodyText2: TextStyle(fontFamily: 'Jura'),
      button: TextStyle(fontFamily: 'Jura'),
      caption: TextStyle(fontFamily: 'Jura'),
      headline1: TextStyle(fontFamily: 'Jura'),
      headline2: TextStyle(fontFamily: 'Jura'),
      headline3: TextStyle(fontFamily: 'Jura'),
      headline4: TextStyle(fontFamily: 'Jura'),
      headline5: TextStyle(fontFamily: 'Jura'),
      headline6: TextStyle(fontFamily: 'Jura'),
      overline: TextStyle(fontFamily: 'Jura'),
      subtitle1: TextStyle(fontFamily: 'Jura'),
      subtitle2: TextStyle(fontFamily: 'Jura'),
    ));
  }
}
