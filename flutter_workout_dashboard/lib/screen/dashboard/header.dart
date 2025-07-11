import 'package:flutter/material.dart';

import '../../constants.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'Hello, Iwan ',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w800,
          ),
        ),
        Spacer(),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 1),
          height: 40,
          width: 250,
          decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: TextFormField(
            style: TextStyle(color: Colors.grey, fontSize: 12),
            decoration: InputDecoration(
              hintText: 'Search...',
              hintStyle: TextStyle(color: Colors.white),
              disabledBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              suffixIcon: Icon(Icons.search, color: Colors.white),
            ),
          ),
        ),
        SizedBox(width: defaultPadding * 2),
        Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Center(child: Icon(Icons.notifications, color: Colors.white)),
        ),
      ],
    );
  }
}
