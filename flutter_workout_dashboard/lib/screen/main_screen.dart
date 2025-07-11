import 'package:flutter/material.dart';
import 'package:flutter_workout_dashboard/screen/dashboard/row1.dart';

import '../constants.dart';
import 'dashboard/header.dart';
import 'dashboard/row2.dart';
import 'side_main.dart';

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
        children: [
          Expanded(child: SingleChildScrollView(child: SideMain())),
          Expanded(
            flex: 4,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: defaultPadding * 2),
              child: Column(
                children: [
                  SizedBox(height: defaultPadding),
                  Header(),
                  SizedBox(height: defaultPadding * 2),
                  Row1(),
                  SizedBox(height: defaultPadding * 2),
                  Row2(),
                  SizedBox(height: defaultPadding),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
