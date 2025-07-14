import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  final Color color1;
  final Color color2;
  final String containerNumber;
  final double containerHeight;
  const CustomContainer({
    Key? key,
    required this.color1,
    required this.color2,
    required this.containerNumber,
    required this.containerHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(50.0),
      height: containerHeight,
      color: color1,
      child: Container(
        color: color2,
        child: Center(
          child: Text(
            'Container $containerNumber',
            style: TextStyle(
              fontSize: 30,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
