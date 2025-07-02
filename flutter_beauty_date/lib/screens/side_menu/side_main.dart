//11:00
import 'package:flutter/material.dart';
import 'package:flutter_beauty_date/constants.dart';
import 'package:flutter_beauty_date/models/main_side_list1.dart';
import 'package:flutter_beauty_date/models/main_side_list2.dart';
import 'package:google_fonts/google_fonts.dart';

class SideMain extends StatefulWidget {
  const SideMain({super.key});

  @override
  State<SideMain> createState() => _SideMainState();
}

class _SideMainState extends State<SideMain> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          color: primaryColor,
          child: Column(
            children: [
              SizedBox(height: defaultPadding * 3),
              RichText(
                text: TextSpan(
                  text: "ADHI",

                  style: GoogleFonts.ubuntu(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: "KURNIA",
                      style: GoogleFonts.ubuntu(
                        color: secondaryColor,
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: defaultPadding * 2),
              Expanded(
                flex: 3,
                child: SizedBox(
                  child: ListView.builder(
                    itemCount: demoMainSideList.length,
                    itemBuilder: (context, index) {
                      return mainSideList1(index, demoMainSideList[index]);
                    },
                  ),
                ),
              ),
              SizedBox(height: defaultPadding * 2),
              Expanded(
                flex: 1,
                child: SizedBox(
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: demoMainSideList2.length,
                    itemBuilder: (context, index) {
                      return mainSideList2(index, demoMainSideList2[index]);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container mainSideList1(int index, MainSideList mainSideList) {
    return Container(
      decoration: BoxDecoration(
        color: _selectedIndex == index ? Color(0xFFCCEDDD) : Colors.transparent,
        gradient: LinearGradient(
          colors: [secondaryColor2, secondaryColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: ListTile(
        hoverColor: Color(0xFFCCEDDD),
        onTap: () {
          setState(() {
            _selectedIndex = mainSideList.index;
          });
        },
        leading: Padding(
          padding: const EdgeInsets.only(left: defaultPadding * 1.5),
          child: SizedBox(
            height: 30,
            width: 30,
            child: Icon(
              mainSideList.icon,
              color: _selectedIndex == index ? Colors.white : Colors.white54,
            ),
          ),
        ),
        title: Text(
          mainSideList.title,
          style: GoogleFonts.ubuntu(
            color: _selectedIndex == index ? Colors.white : Colors.white54,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Container mainSideList2(int index, MainSideList2 mainSideList2) {
    return Container(
      decoration: BoxDecoration(
        color:
            _selectedIndex == index + 7
                ? Color(0xFFCCEDDD)
                : Colors.transparent,
        gradient: LinearGradient(
          colors: [secondaryColor2, secondaryColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: ListTile(
        hoverColor: Color(0xFFCCEDDD),
        onTap: () {
          setState(() {
            _selectedIndex = mainSideList2.index;
          });
        },
        leading: Padding(
          padding: const EdgeInsets.only(left: defaultPadding * 1.5),
          child: SizedBox(
            height: 30,
            width: 30,
            child: Icon(
              mainSideList2.icon,
              color:
                  _selectedIndex == index + 7 ? Colors.white : Colors.white54,
            ),
          ),
        ),
        title: Text(
          mainSideList2.title,
          style: GoogleFonts.ubuntu(
            color: _selectedIndex == index + 7 ? Colors.white : Colors.white54,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
