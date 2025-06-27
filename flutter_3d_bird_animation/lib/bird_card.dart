import 'dart:async';

import 'package:flutter/material.dart';

class BirdCard extends StatefulWidget {
  const BirdCard({super.key});

  @override
  State<BirdCard> createState() => _BirdCardState();
}

class _BirdCardState extends State<BirdCard> {
  bool isTapped = false;
  bool birdFrame = false;
  Timer? birdTimer;

  @override
  void dispose() {
    birdTimer?.cancel();
    super.dispose();
  }

  void startBirdAnimation() {
    birdTimer = Timer.periodic(const Duration(milliseconds: 200), (timer) {
      setState(() {
        birdFrame = !birdFrame;
      });
    });
  }

  void stopBirdAnimation() {
    birdTimer?.cancel();
    birdTimer = null;
    birdFrame = false;
  }

  @override
  Widget build(BuildContext context) {
    Matrix4 transformMatrix =
        isTapped
            ? (Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateX(0.05)
              ..translate(0.0, -50.0))
            : Matrix4.identity();

    return Scaffold(
      backgroundColor: const Color(0xFF6464D0),
      body: Center(
        child: GestureDetector(
          onTapDown: (_) {
            setState(() {
              isTapped = true;
              startBirdAnimation();
            });
          },
          onTapUp: (_) {
            setState(() {
              isTapped = false;
              stopBirdAnimation();
            });
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            width: 300,
            height: 400,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: const DecorationImage(
                image: AssetImage("assets/background.avif"),
                fit: BoxFit.cover,
              ),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black45,
                  blurRadius: 10,
                  offset: Offset(0, 10),
                ),
              ],
            ),
            transform:
                isTapped
                    ? (Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..rotateX(0.05)
                      ..translate(0.0, -50.0))
                    : Matrix4.identity(),
            child: Stack(
              children: [
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 500),
                  bottom: isTapped ? 250 : 100,
                  left: isTapped ? 20 : 50,
                  child: SizedBox(
                    width: 150,
                    height: 150,
                    child: Image.asset(
                      birdFrame ? "assets/bird1.png" : "assets/bird2.png",
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
