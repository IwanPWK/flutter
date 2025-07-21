import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Wallpaper',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.blue,
                fontSize: 22,
              ),
            ),
            Text(
              'App',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.orange,
                fontSize: 22,
              ),
            ),
          ],
        ),
      ),
      body: Center(
        child: Text(
          'Welcome to the Main Page!',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    );
  }
}
