import 'package:flutter/material.dart';

class AppTheme {

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
      primaryColor: Colors.green,
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
