//19:31

//32:01

import 'package:flutter/material.dart';
import 'package:flutter_beauty_date/screens/dashboard/dashboard.dart';
import 'package:flutter_beauty_date/screens/side_menu/side_main.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late ScrollController _scrollController;
  late ScrollController _scrollControllerUncoming;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollControllerUncoming = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _scrollControllerUncoming.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: SideMain()),
          Expanded(
            flex: 4,
            child: SingleChildScrollView(
              child: Dashboard(
                scrollController: _scrollController,
                scrollControllerUncoming: _scrollControllerUncoming,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
