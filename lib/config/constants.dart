import 'package:flutter/material.dart';

abstract class ConstantUitls {
  static const String appName = "Expense Tracker";
  static const String version = "Version 1.0.0";
  static const Color primaryColor = Color(0xFFC1A742);
  static const Color bgColor = Color(0xFF0D1117);
  static const Color lightColor = Colors.white;
  static const Color lightBgColor = Color(0xFFEFEFEF);
  static const double margin = 20;
  static const double radius = 8;
  static const double elevation = 1;

  static const String expense = "Expense";
  static const String income = "Income";

  //method
  static const String getMethod = "GET";
  static const String postMethod = "POST";
  static const String putMethod = "PUT";
  static const String deleteMethod = "DELETE";
}
