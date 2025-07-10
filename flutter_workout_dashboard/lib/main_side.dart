import 'package:flutter/material.dart';

class MainSide {
  final String title;
  final IconData icon;
  final int index;

  MainSide({required this.title, required this.icon, required this.index});
}

List demoMainSide = [
  MainSide(icon: Icons.dashboard_outlined, title: "Dashboard", index: 0),
  MainSide(icon: Icons.rocket_outlined, title: "Activity", index: 1),
  MainSide(icon: Icons.fitness_center_outlined, title: "Workout", index: 2),
  MainSide(icon: Icons.email_outlined, title: "Chat with coach", index: 3),
  MainSide(icon: Icons.egg_alt_outlined, title: "Diets", index: 4),
];
