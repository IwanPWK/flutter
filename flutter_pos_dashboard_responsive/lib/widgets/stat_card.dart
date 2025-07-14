import 'package:flutter/material.dart';
import 'package:flutter_pos_dashboard_responsive/constants/colors.dart';
import 'package:flutter_pos_dashboard_responsive/constants/constants.dart';
import 'package:flutter_pos_dashboard_responsive/data/stat_data.dart';
import 'package:flutter_svg/flutter_svg.dart';

class StatCard extends StatelessWidget {
  final StatInfo info;

  const StatCard({super.key, required this.info});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              // mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.all(
                    AppConstants.defaultPadding * 0.75,
                  ),
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: info.color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: SvgPicture.asset(info.icon, color: info.color),
                ),
                // Spacer(),
                // LayoutBuilder(
                //   builder: (context, constraints) {
                //     double dynamicSpacing =
                //         constraints.maxWidth; // contoh 20% dari lebar Row
                //     return SizedBox(width: dynamicSpacing);
                //   },
                // ),
                SizedBox(width: 50),
                const Icon(Icons.more_vert, color: Colors.white54),
              ],
            ),
            // if (!ResponsiveLayout.isMobile(context))
            const SizedBox(height: AppConstants.defaultPadding),

            // if (!ResponsiveLayout.isMobile(context))
            Text(
              info.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: AppConstants.defaultPadding / 2),
            Text(
              info.total,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
