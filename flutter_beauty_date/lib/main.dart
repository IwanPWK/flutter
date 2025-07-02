import 'package:flutter/material.dart';
import 'package:flutter_beauty_date/screens/main_screen.dart';
import 'package:flutter_beauty_date/constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Adhi Kurnia',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        scaffoldBackgroundColor: bgColor,
        scrollbarTheme: ScrollbarThemeData(
          thumbColor: WidgetStateProperty.all(secondaryColor),
          trackColor: WidgetStateProperty.all(secondaryColor2),
          trackVisibility: WidgetStateProperty.all(true),
          thickness: WidgetStateProperty.all(8),
          radius: Radius.circular(8),
        ),
      ),
      home: const MainScreen(),
    );
  }
}
