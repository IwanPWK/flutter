import 'package:flutter/material.dart';
import 'package:flutter_beauty_date/constants.dart';

class Data {
  final String title;
  final Icon icon1,
      icon2,
      icon3,
      icon4,
      icon5,
      icon6,
      icon7,
      icon8,
      icon9,
      icon10,
      icon11,
      icon12;
  Data({
    required this.title,
    required this.icon1,
    required this.icon2,
    required this.icon3,
    required this.icon4,
    required this.icon5,
    required this.icon6,
    required this.icon7,
    required this.icon8,
    required this.icon9,
    required this.icon10,
    required this.icon11,
    required this.icon12,
  });
}

List demoData = [
  Data(
    title: "Haircut",
    icon1: Icon(Icons.check_circle_sharp, size: 18, color: secondaryColor),
    icon2: Icon(Icons.clear, size: 18, color: Colors.white54),
    icon3: Icon(Icons.clear, size: 18, color: Colors.white54),
    icon4: Icon(Icons.check_circle_sharp, size: 18, color: secondaryColor),
    icon5: Icon(Icons.check_circle_sharp, size: 18, color: secondaryColor),
    icon6: Icon(Icons.check_circle_sharp, size: 18, color: secondaryColor),
    icon7: Icon(Icons.check_circle_sharp, size: 18, color: secondaryColor),
    icon8: Icon(Icons.clear, size: 18, color: Colors.white54),
    icon9: Icon(Icons.clear, size: 18, color: Colors.white54),
    icon10: Icon(Icons.check_circle_sharp, size: 18, color: secondaryColor),
    icon11: Icon(Icons.check_circle_sharp, size: 18, color: secondaryColor),
    icon12: Icon(Icons.clear, size: 18, color: Colors.white54),
  ),
  Data(
    title: "Hair color",
    icon1: Icon(Icons.check_circle_sharp, size: 18, color: secondaryColor2),
    icon2: Icon(Icons.clear, size: 18, color: Colors.white54),
    icon3: Icon(Icons.check_circle_sharp, size: 18, color: secondaryColor2),
    icon4: Icon(Icons.check_circle_sharp, size: 18, color: secondaryColor2),
    icon5: Icon(Icons.clear, size: 18, color: Colors.white54),
    icon6: Icon(Icons.clear, size: 18, color: Colors.white54),
    icon7: Icon(Icons.check_circle_sharp, size: 18, color: secondaryColor2),
    icon8: Icon(Icons.check_circle_sharp, size: 18, color: secondaryColor2),
    icon9: Icon(Icons.clear, size: 18, color: Colors.white54),
    icon10: Icon(Icons.check_circle_sharp, size: 18, color: secondaryColor2),
    icon11: Icon(Icons.clear, size: 18, color: Colors.white54),
    icon12: Icon(Icons.check_circle_sharp, size: 18, color: secondaryColor2),
  ),
  Data(
    title: "Nails",
    icon1: Icon(Icons.clear, size: 18, color: Colors.white54),
    icon2: Icon(Icons.check_circle_sharp, size: 18, color: Color(0xFF01DFFF)),
    icon3: Icon(Icons.check_circle_sharp, size: 18, color: Color(0xFF01DFFF)),
    icon4: Icon(Icons.clear, size: 18, color: Colors.white54),
    icon5: Icon(Icons.clear, size: 18, color: Colors.white54),
    icon6: Icon(Icons.check_circle_sharp, size: 18, color: Color(0xFF01DFFF)),
    icon7: Icon(Icons.check_circle_sharp, size: 18, color: Color(0xFF01DFFF)),
    icon8: Icon(Icons.clear, size: 18, color: Colors.white54),
    icon9: Icon(Icons.check_circle_sharp, size: 18, color: Color(0xFF01DFFF)),
    icon10: Icon(Icons.clear, size: 18, color: Colors.white54),
    icon11: Icon(Icons.check_circle_sharp, size: 18, color: Color(0xFF01DFFF)),
    icon12: Icon(Icons.check_circle_sharp, size: 18, color: Color(0xFF01DFFF)),
  ),
  Data(
    title: "Makeup",
    icon1: Icon(Icons.check_circle_sharp, size: 18, color: Color(0xFF4FF0B4)),
    icon2: Icon(Icons.check_circle_sharp, size: 18, color: Color(0xFF4FF0B4)),
    icon3: Icon(Icons.clear, size: 18, color: Colors.white54),
    icon4: Icon(Icons.check_circle_sharp, size: 18, color: Color(0xFF4FF0B4)),
    icon5: Icon(Icons.clear, size: 18, color: Colors.white54),
    icon6: Icon(Icons.check_circle_sharp, size: 18, color: Color(0xFF4FF0B4)),
    icon7: Icon(Icons.clear, size: 18, color: Colors.white54),
    icon8: Icon(Icons.check_circle_sharp, size: 18, color: Color(0xFF4FF0B4)),
    icon9: Icon(Icons.check_circle_sharp, size: 18, color: Color(0xFF4FF0B4)),
    icon10: Icon(Icons.clear, size: 18, color: Colors.white54),
    icon11: Icon(Icons.clear, size: 18, color: Colors.white54),
    icon12: Icon(Icons.check_circle_sharp, size: 18, color: Color(0xFF4FF0B4)),
  ),
  Data(
    title: "Massage",
    icon1: Icon(Icons.check_circle_sharp, size: 18, color: Color(0xFFF9A266)),
    icon2: Icon(Icons.clear, size: 18, color: Colors.white54),
    icon3: Icon(Icons.clear, size: 18, color: Colors.white54),
    icon4: Icon(Icons.check_circle_sharp, size: 18, color: Color(0xFFF9A266)),
    icon5: Icon(Icons.check_circle_sharp, size: 18, color: Color(0xFFF9A266)),
    icon6: Icon(Icons.clear, size: 18, color: Colors.white54),
    icon7: Icon(Icons.check_circle_sharp, size: 18, color: Color(0xFFF9A266)),
    icon8: Icon(Icons.check_circle_sharp, size: 18, color: Color(0xFFF9A266)),
    icon9: Icon(Icons.clear, size: 18, color: Colors.white54),
    icon10: Icon(Icons.check_circle_sharp, size: 18, color: Color(0xFFF9A266)),
    icon11: Icon(Icons.check_circle_sharp, size: 18, color: Color(0xFFF9A266)),
    icon12: Icon(Icons.clear, size: 18, color: Colors.white54),
  ),
  Data(
    title: "Skincare",
    icon1: Icon(Icons.clear, size: 18, color: Colors.white54),
    icon2: Icon(Icons.check_circle_sharp, size: 18, color: Color(0xFFF9CE62)),
    icon3: Icon(Icons.check_circle_sharp, size: 18, color: Color(0xFFF9CE62)),
    icon4: Icon(Icons.clear, size: 18, color: Colors.white54),
    icon5: Icon(Icons.check_circle_sharp, size: 18, color: Color(0xFFF9CE62)),
    icon6: Icon(Icons.clear, size: 18, color: Colors.white54),
    icon7: Icon(Icons.clear, size: 18, color: Colors.white54),
    icon8: Icon(Icons.check_circle_sharp, size: 18, color: Color(0xFFF9CE62)),
    icon9: Icon(Icons.check_circle_sharp, size: 18, color: Color(0xFFF9CE62)),
    icon10: Icon(Icons.clear, size: 18, color: Colors.white54),
    icon11: Icon(Icons.check_circle_sharp, size: 18, color: Color(0xFFF9CE62)),
    icon12: Icon(Icons.check_circle_sharp, size: 18, color: Color(0xFFF9CE62)),
  ),
];
