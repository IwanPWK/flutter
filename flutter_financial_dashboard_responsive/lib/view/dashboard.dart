import 'package:flutter/material.dart';
import 'package:flutter_financial_dashboard_responsive/config/size_config.dart';
import 'package:flutter_financial_dashboard_responsive/util/colors.dart';

import '../config/responsive.dart';
import 'widgets/header_action_items.dart';
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
    );
  }
}
