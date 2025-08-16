import 'package:flutter/material.dart';

import '../../responsive/responsive.dart';

class ProfileAndIntro extends StatelessWidget {
  const ProfileAndIntro({super.key});

  @override
  Widget build(BuildContext context) {
    const double heightSizedBox = 200;
    const double widthSizedBox = 300;

    print('height: ${Responsive.heightOfScreen(context)}');
    // print('width: ${Responsive.widthOfScreen(context)}');
    return Wrap(
      alignment: WrapAlignment.center,
      children: [
        SizedBox(
          width:
              Responsive.isMobile(context)
                  // it take full widt in mobile screen but only tkes half width in web and desktop
                  ? Responsive.widthOfScreen(context)
                  : Responsive.widthOfScreen(context) / 2,
          height:
              Responsive.isMobile(context)
                  ? Responsive.heightOfScreen(context) / 3
                  : Responsive.heightOfScreen(context) - 70,
          child: Image.asset("asset/images/profile-image.png"),
        ),
        ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: heightSizedBox,
            // minWidth: widthSizedBox,
            // maxHeight: heightSizedBox,
          ),
          child: SizedBox(
            width:
                Responsive.isMobile(context)
                    // it take full widt in mobile screen but only tkes half width in web and desktop
                    ? Responsive.widthOfScreen(context)
                    : Responsive.widthOfScreen(context) / 2,
            height:
                Responsive.isMobile(context)
                    ? Responsive.heightOfScreen(context) / 3
                    : Responsive.heightOfScreen(context) - 70,

            child: Center(
              child: SizedBox(
                height: 250,
                width:
                    Responsive.isMobile(context)
                        ? Responsive.widthOfScreen(context) * 0.85
                        : 450,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 8,
                        spreadRadius: 5,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Hello!",
                            style: TextStyle(
                              fontSize: Responsive.isMobile(context) ? 30 : 40,
                              color: Colors.red,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          Text(
                            "I'm Kurniawan,\na Developer & Content Creator\nSpecializing in Flutter App Development and UI Design.",
                            style: TextStyle(
                              overflow: TextOverflow.ellipsis,
                              fontSize: Responsive.isMobile(context) ? 16 : 24,
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines:
                                Responsive.isMobile(context)
                                    ? 5
                                    : 4, // batas jumlah baris (atur sesuai tinggi box)
                            softWrap:
                                true, // biar tetap bisa pindah baris sebelum dipotong
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
