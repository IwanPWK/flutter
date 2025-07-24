import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final Widget leading;
  final String title;
  final String subtitle;
  final Widget trailing;
  const Header({
    super.key,
    required this.leading,
    required this.title,
    required this.subtitle,
    required this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 24),
      leading:
          leading, // homeScreen -> profile, accountDetailScreen -> back button
      title: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
      ), // homeScreen -> user name, accountDetailScreen -> customerName
      subtitle: Text(
        subtitle,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontSize: 16,
        ),
      ), // homeScreen -> net Balance, accountDetailScreen-> createDate
      trailing: trailing, // homeScreen and accountDetailScreen -> button
    );
  }
}
