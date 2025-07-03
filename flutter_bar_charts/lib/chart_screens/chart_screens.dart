import 'package:flutter/material.dart';
import 'package:flutter_bar_charts/chart_screens/bar_charts.dart';
import 'package:flutter_bar_charts/chart_screens/common_vertical_bar_charts.dart';
import 'package:flutter_bar_charts/chart_screens/floating_range_column_charts.dart';
import 'package:flutter_bar_charts/chart_screens/range_column_charts.dart';
import 'package:flutter_bar_charts/chart_screens/vertical_bar_charts.dart';
import 'package:flutter_bar_charts/constants.dart';

class ChartScreens extends StatelessWidget {
  const ChartScreens({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(defaultPadding),
            child: Column(
              children: [
                BarCharts(),
                SizedBox(height: defaultPadding),
                VerticalBarCharts(),
                SizedBox(height: defaultPadding),
                RangeColumnCharts(),
                SizedBox(height: defaultPadding),
                FloatingRangeColumnCharts(),
                SizedBox(height: defaultPadding),
                CommonVerticalBarCharts(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
