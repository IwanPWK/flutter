import 'package:flutter/material.dart';
import 'package:flutter_workout_dashboard/constants.dart';
import 'package:flutter_workout_dashboard/main_side.dart';
import 'package:flutter_workout_dashboard/main_side_setting.dart';

class SideMain extends StatefulWidget {
  const SideMain({super.key});

  @override
  State<SideMain> createState() => _SideMainState();
}

class _SideMainState extends State<SideMain> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: primaryColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black87,
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          SizedBox(height: defaultPadding * 2),
          Container(
            height: 50,
            child: Text(
              'Workout Go',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          SizedBox(height: defaultPadding * 2),
          SizedBox(
            height: 250,
            child: ListView.builder(
              itemCount: demoMainSide.length,
              itemBuilder: (context, index) {
                return ListTile1(index, demoMainSide[index]);
              },
            ),
          ),
          SizedBox(height: defaultPadding * 2),
          SizedBox(
            height: 150,
            child: ListView.builder(
              itemCount: demoMainSideSetting.length,
              itemBuilder: (context, index) {
                return ListTile2(index, demoMainSideSetting[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Container ListTile1(int index, MainSide mainside) {
    return Container(
      decoration: BoxDecoration(
        color: _selectedIndex == index ? Color(0xFFCCEDDD) : Colors.transparent,
        gradient: LinearGradient(
          colors: [Color(0xFF58D9D9), Color(0xFF5747EF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: ListTile(
        hoverColor: Color(0xFFCCEDDD),
        onTap: () {
          setState(() {
            _selectedIndex = mainside.index;
          });
        },
        leading: Padding(
          padding: const EdgeInsets.only(left: defaultPadding * 1.5),
          child: SizedBox(
            height: 30,
            width: 30,
            child: Icon(
              mainside.icon,
              color:
                  _selectedIndex == index
                      ? Color.fromARGB(255, 0, 0, 0)
                      : Color.fromARGB(225, 233, 230, 230),
            ),
          ),
        ),
        title: Text(
          mainside.title,
          style: TextStyle(
            color:
                _selectedIndex == index
                    ? Color.fromARGB(255, 0, 0, 0)
                    : Color.fromARGB(248, 255, 255, 255),
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Container ListTile2(int index, MainSideSetting mainsidesetting) {
    return Container(
      decoration: BoxDecoration(
        color:
            _selectedIndex == index + 5
                ? Color(0xFFCCEDDD)
                : Colors.transparent,
        gradient: LinearGradient(
          colors: [Color(0xFF58D9D9), Color(0xFF5747EF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: ListTile(
        hoverColor: Color(0xFFCCEDDD),
        onTap: () {
          setState(() {
            _selectedIndex = mainsidesetting.index;
          });
        },
        leading: Padding(
          padding: const EdgeInsets.only(left: defaultPadding * 1.5),
          child: SizedBox(
            height: 30,
            width: 30,
            child: Icon(
              mainsidesetting.icon,
              color:
                  _selectedIndex == index + 5
                      ? Color.fromARGB(255, 0, 0, 0)
                      : Color.fromARGB(225, 233, 230, 230),
            ),
          ),
        ),
        title: Text(
          mainsidesetting.title,
          style: TextStyle(
            color:
                _selectedIndex == index + 5
                    ? Color.fromARGB(255, 0, 0, 0)
                    : Color.fromARGB(248, 255, 255, 255),
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
