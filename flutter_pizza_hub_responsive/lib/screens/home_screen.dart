import 'package:flutter/material.dart';

import '../footer/footer_section.dart';
import '../sections/body/body.dart';
import '../sections/head/header_section.dart';
import '../sections/head/my_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      // for mobile screen
      drawer: MyDrawer(),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              //Head
              HeaderSection(),
              // Body
              BodySection(),
              // Footer
              FooterSection(),
            ],
          ),
        ),
      ),
    );
  }
}
