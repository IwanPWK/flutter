import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import '../../config/responsive.dart';
import '../../util/colors.dart';

class BarChartRepresentation extends StatelessWidget {
  const BarChartRepresentation({super.key});

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        barGroups: [_generateBarGroups(context)],
        borderData: FlBorderData(show: false),
        alignment: BarChartAlignment.spaceBetween,
        gridData: const FlGridData(
          drawHorizontalLine: true,
          horizontalInterval: 30,
        ),
        barTouchData: BarTouchData(
          touchTooltipData: BarTouchTooltipData(
            getTooltipColor: (_) => Colors.transparent,
          ),
          handleBuiltInTouches: false,
        ),
        titlesData: FlTitlesData(
          show: true,
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40,
              interval: 30,
              getTitlesWidget: (value, meta) {
                print('value: $value');
                switch (value.toInt()) {
                  case 0:
                    return const Text(
                      '0',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    );
                  case 30:
                    return const Text(
                      '10k',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    );
                  case 60:
                    return const Text(
                      '50k',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    );
                  case 90:
                    return const Text(
                      '100k',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    );
                  default:
                    return const SizedBox.shrink();
                }
              },
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40,
              getTitlesWidget: (value, meta) {
                final months = [
                  'JAN',
                  'FEB',
                  'MAR',
                  'APR',
                  'MAY',
                  'JUN',
                  'JUL',
                  'AUG',
                  'SEP',
                  'OCT',
                  'NOV',
                  'DEC',
                ];
                if (value.toInt() >= 0 && value.toInt() < months.length) {
                  return Text(
                    months[value.toInt()],
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
          topTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 50,
              getTitlesWidget: (value, meta) {
                final months = [
                  'JAN',
                  'FEB',
                  'MAR',
                  'APR',
                  'MAY',
                  'JUN',
                  'JUL',
                  'AUG',
                  'SEP',
                  'OCT',
                  'NOV',
                  'DEC',
                ];
                if (value.toInt() >= 0 && value.toInt() < months.length) {
                  return Text(
                    months[value.toInt()],
                    style: const TextStyle(fontSize: 12, color: Colors.black),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ),
      ),
      duration: const Duration(milliseconds: 150),
      curve: Curves.linear,
    );
  }

  BarChartGroupData _generateBarGroups(BuildContext context) {
    final List<double> values = [
      20,
      35,
      50,
      90,
      60,
      40,
      25,
      15,
      70,
      90,
      70,
      60,
    ];

    return BarChartGroupData(
      x: 0,
      barsSpace: 4,
      barRods: List.generate(values.length, (index) {
        return BarChartRodData(
          toY: values[index],
          color: Colors.black,
          width: Responsive.isDesktop(context) ? 40 : 10,
          borderRadius: BorderRadius.zero,
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            toY: 90,
            color: MyAppColor.barBg,
          ),
        );
      }),
      showingTooltipIndicators: List.generate(values.length, (index) => index),
    );
  }
}
