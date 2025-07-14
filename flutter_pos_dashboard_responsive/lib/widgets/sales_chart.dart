import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pos_dashboard_responsive/constants/colors.dart';

class SalesChart extends StatelessWidget {
  const SalesChart({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: LineChart(
        LineChartData(
          gridData: const FlGridData(show: false),
          titlesData: const FlTitlesData(show: false),
          borderData: FlBorderData(show: false),
          lineBarsData: [
            LineChartBarData(
              spots: [
                const FlSpot(0, 3),
                const FlSpot(2.6, 2),
                const FlSpot(4.9, 5),
                const FlSpot(6.8, 3.1),
                const FlSpot(8, 4),
                const FlSpot(9.5, 3),
                const FlSpot(11, 4),
              ],
              isCurved: true,
              color: primaryColor,
              barWidth: 5,
              isStrokeCapRound: true,
              dotData: const FlDotData(show: false),
              belowBarData: BarAreaData(
                show: true,
                color: primaryColor.withOpacity(0.3),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
