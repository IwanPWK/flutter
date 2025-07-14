import 'package:flutter/material.dart';
import 'package:flutter_pos_dashboard_responsive/constants/colors.dart';
import 'package:flutter_pos_dashboard_responsive/responsive/responsive_layout.dart';
import 'package:flutter_pos_dashboard_responsive/screens/dashboard_screen.dart';
import 'package:flutter_pos_dashboard_responsive/widgets/side_menu.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter POS Dashboard',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: bgColor,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
            .apply(bodyColor: Colors.white),
        canvasColor: secondaryColor,
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (ResponsiveLayout.isDesktop(context))
              const Expanded(
                child: SideMenu(),
              ),
            const Expanded(
              flex: 5,
              child: DashboardScreen(),
            ),
          ],
        ),
      ),
    );
  }
}