import 'package:flutter/material.dart';
import 'package:flutter_bar_charts/chart_screens/bar_charts.dart';
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
            child: Column(children: [BarCharts()]),
          ),
        ),
      ),
    );
  }
}
