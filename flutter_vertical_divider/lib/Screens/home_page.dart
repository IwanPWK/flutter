import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text('Vertical Divider')),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: const [
          DescriptionTxt(
            title: 'Distance',
            subTitle: '1.6Km/Day',
            txtColor: Colors.blue,
          ),

          // - - - Vertical Divider - - -
          VerticalDivider(
            color: Colors.grey,
            thickness: 2,
            indent: 300,
            endIndent: 300,
          ),

          // - - - - - - - - - - - -
          DescriptionTxt(
            title: 'Move',
            subTitle: '62Kcal/Day',
            txtColor: Colors.red,
          ),
        ],
      ),
    );
  }
}

class DescriptionTxt extends StatelessWidget {
  const DescriptionTxt({
    super.key,
    required this.title,
    required this.subTitle,
    required this.txtColor,
  });

  final String title;
  final String subTitle;
  final Color txtColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(title, style: const TextStyle(fontSize: 22)),
        Text(
          subTitle,
          style: TextStyle(
            fontSize: 30,
            color: txtColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
