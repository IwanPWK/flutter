import 'package:flutter/material.dart';
import 'package:flutter_financial_dashboard_responsive/config/size_config.dart';
import 'package:flutter_financial_dashboard_responsive/util/colors.dart';

import '../config/responsive.dart';
import '../model/model.dart';
import 'transfer_info_card.dart';
import 'widgets/header_action_items.dart';
import 'widgets/header_parts.dart';
import 'widgets/side_drawer_menu.dart';

class MyDashboard extends StatelessWidget {
  final GlobalKey<ScaffoldState> drawerKey = GlobalKey();

  MyDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: MyAppColor.backgroundColor,
      key: drawerKey,
      drawer: const SizedBox(width: 100, child: SideDrawerMenu()),
      appBar:
          !Responsive.isDesktop(context)
              ? AppBar(
                elevation: 0,
                backgroundColor: Colors.white,
                leading: IconButton(
                  onPressed: () {
                    drawerKey.currentState!.openDrawer();
                  },
                  icon: const Icon(Icons.menu, color: Colors.black),
                ),
                actions: const [HeaderActionItems()],
              )
              : const PreferredSize(
                preferredSize: Size.zero,
                child: SizedBox(),
              ),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (Responsive.isDesktop(context))
              const Expanded(flex: 1, child: SideDrawerMenu()),
            Expanded(
              flex: 10,
              child: SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    vertical: 30,
                    horizontal: 30,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // for dashboard text, search bar
                      const HeaderParts(),
                      SizedBox(height: SizeConfig.blockSizeVertical * 4),
                      // for transfor info
                      SizedBox(
                        width: SizeConfig.screenWidth,
                        child: Wrap(
                          spacing: 20,
                          runSpacing: 20,
                          alignment: WrapAlignment.spaceBetween,
                          // Dynamically map over infoCardData
                          children:
                              infoCardData.map((info) {
                                return TransferInfoCard(infoCardModel: info);
                              }).toList(),
                        ),
                      ),
                      SizedBox(height: SizeConfig.blockSizeVertical * 4),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
