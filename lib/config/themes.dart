import 'package:expense/config/constants.dart';
import 'package:flutter/material.dart';

final lightTheme = buildLightTheme();
final darkTheme = buildDarkTheme();

ThemeData buildLightTheme() {
  final ThemeData base = ThemeData(
      backgroundColor: ConstantUitls.lightColor,
      scaffoldBackgroundColor: ConstantUitls.lightBgColor,
      fontFamily: 'Poppins',
      primaryColor: ConstantUitls.primaryColor,
      appBarTheme: const AppBarTheme(
        backgroundColor: ConstantUitls.primaryColor,
        elevation: ConstantUitls.elevation,
      ),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      brightness: Brightness.light,
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: ConstantUitls.primaryColor));
  return base;
}

ThemeData buildDarkTheme() {
  final ThemeData base = ThemeData(
      backgroundColor: Colors.orange,
      scaffoldBackgroundColor: ConstantUitls.bgColor,
      fontFamily: 'Poppins',
      primaryColor: ConstantUitls.primaryColor,
      appBarTheme: const AppBarTheme(
        backgroundColor: ConstantUitls.primaryColor,
        elevation: 1,
      ),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      brightness: Brightness.dark,
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: ConstantUitls.primaryColor));
  return base;
}
