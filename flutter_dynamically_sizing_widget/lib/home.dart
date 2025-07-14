import 'package:flutter/material.dart';

import 'custom_container.dart';

class Home extends StatelessWidget {
  final appBar = AppBar(
    title: Text('Get Screen Size'),
    centerTitle: true,
    backgroundColor: Color(0xFF45D1FD),
  );
  Home({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final appBarHeight = appBar.preferredSize.height;
    final statusBarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
      appBar: AppBar(),

      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomContainer(
              color1: Colors.deepOrange,
              color2: Colors.orange,
              containerNumber: '1',
              containerHeight:
                  (screenHeight - appBarHeight - statusBarHeight) * 0.5,
            ),
            CustomContainer(
              color1: Colors.blue,
              color2: Colors.blueGrey,
              containerNumber: '2',
              containerHeight:
                  (screenHeight - appBarHeight - statusBarHeight) * 0.5,
            ),
          ],
        ),
      ),
    );
  }
}
