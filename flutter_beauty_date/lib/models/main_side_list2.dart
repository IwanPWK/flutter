import 'package:flutter/material.dart';

class MainSideList2 {
  final String title;
  final IconData icon;
  final int index;

  MainSideList2({required this.title, required this.icon, required this.index});
}

List demoMainSideList2 = [
  MainSideList2(icon: Icons.settings, title: "Settings", index: 7),
  MainSideList2(icon: Icons.logout_outlined, title: "Log out", index: 8),
];
