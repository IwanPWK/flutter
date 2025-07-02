import 'package:flutter/material.dart';

class MainSideList {
  final String title;
  final IconData icon;
  final int index;

  MainSideList({required this.title, required this.icon, required this.index});
}

List demoMainSideList = [
  MainSideList(icon: Icons.home_outlined, title: "Home", index: 0),
  MainSideList(icon: Icons.dashboard_outlined, title: "Dashboard", index: 1),
  MainSideList(icon: Icons.group_outlined, title: "Masters", index: 2),
  MainSideList(icon: Icons.event_outlined, title: "Schedule", index: 3),
  MainSideList(icon: Icons.groups_outlined, title: "Clients", index: 4),
  MainSideList(icon: Icons.chat_outlined, title: "Chat", index: 5),
  MainSideList(
    icon: Icons.notifications_outlined,
    title: "Notifications",
    index: 6,
  ),
];
