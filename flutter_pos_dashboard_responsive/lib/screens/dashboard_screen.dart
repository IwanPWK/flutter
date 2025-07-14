import 'package:flutter/material.dart';
import 'package:flutter_pos_dashboard_responsive/constants/constants.dart';
import 'package:flutter_pos_dashboard_responsive/responsive/responsive_layout.dart';
import 'package:flutter_pos_dashboard_responsive/widgets/header.dart';
import 'package:flutter_pos_dashboard_responsive/widgets/recent_sales_list.dart';
import 'package:flutter_pos_dashboard_responsive/widgets/sales_chart.dart';
import 'package:flutter_pos_dashboard_responsive/widgets/stat_list.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        child: Column(
          children: [
            const Header(),
            const SizedBox(height: AppConstants.defaultPadding),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    children: [
                      const StatList(),
                      const SizedBox(height: AppConstants.defaultPadding),
                      const SalesChart(),
                      const SizedBox(height: AppConstants.defaultPadding),
                      if (ResponsiveLayout.isMobile(context))
                        const RecentSalesList(),
                    ],
                  ),
                ),
                if (!ResponsiveLayout.isMobile(context))
                  const SizedBox(width: AppConstants.defaultPadding),
                if (!ResponsiveLayout.isMobile(context))
                  const Expanded(flex: 2, child: RecentSalesList()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
