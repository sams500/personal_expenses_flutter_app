import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

AppTheme currentAppTheme = AppTheme();

class AppTheme extends ChangeNotifier {
  static bool isDark = false;

  ThemeMode get currentThemeMode => isDark ? ThemeMode.dark : ThemeMode.light;

  void switchMode() {
    isDark = !isDark;
    notifyListeners();
  }

  static ThemeData light() {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: Colors.purple,
      primarySwatch: Colors.purple,
      appBarTheme: const AppBarTheme(
        foregroundColor: Colors.white,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        foregroundColor: Colors.white,
      ),
      textTheme: const TextTheme(
        headline6: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 20.0,
          color: Colors.black,
        ),
        subtitle1: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 20.0,
          color: Colors.white,
        ),
        bodyText1: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 18,
          color: Colors.black,
        ),
      ),
    );
  }

  static ThemeData dark() {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: const Color.fromRGBO(76, 175, 80, 100),
      primarySwatch: Colors.green,
      appBarTheme: const AppBarTheme(
        foregroundColor: Colors.white,
        backgroundColor: Color.fromRGBO(76, 175, 80, 100),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        foregroundColor: Colors.white,
        backgroundColor: Color.fromRGBO(76, 175, 80, 100),
      ),
      textTheme: const TextTheme(
        headline6: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 20.0,
          color: Colors.white,
        ),
        subtitle1: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 20.0,
          color: Colors.white,
        ),
        bodyText1: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 18,
          color: Colors.white,
        ),
      ),
    );
  }
}
