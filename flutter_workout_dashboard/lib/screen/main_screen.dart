import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_workout_dashboard/screen/dashboard/row1.dart';

import '../constants.dart';
import 'dashboard/header.dart';
import 'dashboard/row2.dart';
import 'dashboard/row3.dart';
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
            child: Center(
              //if you want to scroll vertically, or if without it, wheel to scroll vertically or shift + wheel to scroll horizontally
              child: ScrollConfiguration(
                behavior: MyCustomScrollBehavior(),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,

                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      width: 1060,
                      padding: EdgeInsets.symmetric(
                        horizontal: defaultPadding * 2,
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: defaultPadding),
                          Header(),
                          SizedBox(height: defaultPadding * 2),
                          Row1(),
                          SizedBox(height: defaultPadding * 2),
                          Row2(),
                          SizedBox(height: defaultPadding),
                          Row3(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
  };
}
