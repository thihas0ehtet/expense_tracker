import 'package:expense/config/languages.dart';
import 'package:expense/config/themes.dart';
import 'package:expense/services/database_service.dart';
import 'package:expense/widgets/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseService.initDB();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Expense Tracker',
        debugShowCheckedModeBanner: false,
        translations: Languages(),
        locale: const Locale('mm', 'Uni'),
        fallbackLocale: const Locale('mm', 'Uni'),
        theme: context.isDarkMode ? darkTheme : lightTheme,
        home: const BottomBar());
  }
}
