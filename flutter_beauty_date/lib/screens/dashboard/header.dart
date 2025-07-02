import 'package:flutter/material.dart';
import 'package:flutter_beauty_date/constants.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Spacer(),
        Container(
          height: 40,
          width: 250,
          padding: EdgeInsets.only(left: defaultPadding),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: primaryColor,
          ),
          child: TextFormField(
            initialValue: 'Search...',
            style: TextStyle(color: Colors.grey, fontSize: 12),
            decoration: InputDecoration(
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
          child: Icon(Icons.notifications, color: Colors.white),
        ),
      ],
    );
  }
}
