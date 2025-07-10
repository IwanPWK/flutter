import 'package:flutter/material.dart';
import 'package:flutter_workout_dashboard/constants.dart';
import 'package:flutter_workout_dashboard/screen/side_main.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Row(
        children: [Expanded(child: SingleChildScrollView(child: SideMain()))],
      ),
    );
  }
}
