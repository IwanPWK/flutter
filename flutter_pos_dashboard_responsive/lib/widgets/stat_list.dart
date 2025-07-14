import 'package:flutter/material.dart';
import 'package:flutter_pos_dashboard_responsive/constants/constants.dart';
import 'package:flutter_pos_dashboard_responsive/data/stat_data.dart';
import 'package:flutter_pos_dashboard_responsive/widgets/stat_card.dart';

import '../responsive/responsive_layout.dart';

class StatList extends StatelessWidget {
  const StatList({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: ResponsiveLayout.isMobile(context) ? 2 : 4,
        crossAxisSpacing: AppConstants.defaultPadding,
        mainAxisSpacing: AppConstants.defaultPadding,
        childAspectRatio: 1.5,
      ),
      itemCount: 4,
      itemBuilder: (context, index) {
        return StatCard(
          info: StatInfo(
            icon: 'assets/icons/menu_doc.svg',
            title: 'Total Penjualan',
            total: 'Rp 1.500.000',
            color: Colors.blue,
          ),
        );
      },
    );
  }
}
