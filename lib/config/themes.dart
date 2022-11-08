import 'package:expense/config/constants.dart';
import 'package:flutter/material.dart';

final lightTheme = buildLightTheme();
final darkTheme = buildDarkTheme();

ThemeData buildLightTheme() {
  final ThemeData base = ThemeData(
      backgroundColor: Colors.white,
      scaffoldBackgroundColor: lightSecondaryColor,
      fontFamily: 'Poppins',
      primaryColor: primaryColor,
      appBarTheme: const AppBarTheme(
        backgroundColor: primaryColor,
        elevation: 1,
      ),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      brightness: Brightness.light,
      floatingActionButtonTheme: const FloatingActionButtonThemeData(backgroundColor: primaryColor));
  return base;
}

ThemeData buildDarkTheme() {
  final ThemeData base = ThemeData(
      backgroundColor: Colors.orange,
      scaffoldBackgroundColor: bgColor,
      fontFamily: 'Poppins',
      primaryColor: primaryColor,
      appBarTheme: const AppBarTheme(
        backgroundColor: primaryColor,
        elevation: 1,
      ),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      brightness: Brightness.dark,
      floatingActionButtonTheme: const FloatingActionButtonThemeData(backgroundColor: primaryColor));
  return base;
}
