import 'package:flutter/material.dart';
import 'package:flutter_3d_bird_animation/bird_card.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: BirdCard(),
      debugShowCheckedModeBanner: false,
    );
  }
}
