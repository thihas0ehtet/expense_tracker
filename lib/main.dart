import 'package:expense/config/languages.dart';
import 'package:expense/config/themes.dart';
import 'package:expense/ui/screens/home_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Expense Tracker',
        debugShowCheckedModeBanner: false,
        translations: Languages(),
        locale: const Locale('mm', 'Uni'),
        fallbackLocale: const Locale('mm', 'Uni'),
        theme: context.isDarkMode ? darkTheme : lightTheme,
        home: const HomeScreen());
  }
}
