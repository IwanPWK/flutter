import 'package:flutter/material.dart';

import '../widgets/drawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
      ),
      drawer: DrawerWidget(),
      body: ListView(children: [_buildHeatMap()]),
    );
  }

  
}
