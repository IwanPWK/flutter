import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double myAngle = 0.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown.withValues(alpha: 0.5),
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: -170,
            child: AnimatedRotation(
              curve: Curves.fastEaseInToSlowEaseOut,
              duration: const Duration(seconds: 3),
              turns: myAngle,
              child: CircleAvatar(
                backgroundColor: Colors.brown.withValues(alpha: 0.31),
                radius: 210,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(
                      bottom: -81,
                      right: (MediaQuery.of(context).size.width / 2) - 81,
                      child: const CircleAvatar(
                        radius: 81,
                        backgroundColor: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() => myAngle += 1),
        child: const Icon(Icons.rotate_right_outlined),
      ),
    );
  }
}
