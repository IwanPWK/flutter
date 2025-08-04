import 'dart:math';


import 'package:fl_chart_flutter/fl_chart_flutter.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const ChartShowCase(),
    );
  }
}

class ChartShowCase extends StatefulWidget {
  const ChartShowCase({super.key});

  @override
  State<ChartShowCase> createState() => _ChartShowCaseState();
}

class _ChartShowCaseState extends State<ChartShowCase>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FL Chart"),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: [
            Tab(text: "Line"),
            Tab(text: "Bar"),
            Tab(text: "Pie"),
            Tab(text: "Scatter"),
            Tab(text: "Radar"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          LineChartWidget(),
          BarChartWidget(),
          PieChartWidget(),
          ScatterChartWidget(),
          RadarChartWidget(),
        ],
      ),
    );
  }
}

// LINE CHART
class LineChartWidget extends StatelessWidget {
  const LineChartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        lineBarsData: [
          LineChartBarData(
            isCurved: true,
            spots: [
              FlSpot(0, 1),
              FlSpot(1, 3),
              FlSpot(2, 5),
              FlSpot(3, 4),
              FlSpot(4, 7),
            ],
            color: Colors.blue,
            barWidth: 4,
            dotData: FlDotData(show: true),
          ),
        ],
      ),
    );
  }
}

// BAR CHART
class BarChartWidget extends StatelessWidget {
  const BarChartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        barGroups: List.generate(6, (i) {
          return BarChartGroupData(
            x: i,
            barRods: [
              BarChartRodData(toY: (i + 1) * 2.0, color: Colors.orange),
            ],
          );
        }),
      ),
    );
  }
}

// PIE CHART
class PieChartWidget extends StatelessWidget {
  const PieChartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return PieChart(
      PieChartData(
        sections: [
          PieChartSectionData(
            value: 30,
            title: 'A',
            color: Colors.red,
            radius: 60,
          ),
          PieChartSectionData(
            value: 25,
            title: 'B',
            color: Colors.blue,
            radius: 60,
          ),
          PieChartSectionData(
            value: 20,
            title: 'C',
            color: Colors.green,
            radius: 60,
          ),
          PieChartSectionData(
            value: 25,
            title: 'D',
            color: Colors.orange,
            radius: 60,
          ),
        ],
      ),
    );
  }
}

// SCATTERCHARTWIDGET
class ScatterChartWidget extends StatelessWidget {
  const ScatterChartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ScatterChart(
      ScatterChartData(
        scatterSpots: List.generate(20, (i) {
          return ScatterSpot(
            Random().nextDouble() * 10,
            Random().nextDouble() * 20,
          );
        }),
        minX: 0,
        maxX: 10,
        minY: 0,
        maxY: 10,
      ),
    );
  }
}


// RADAR CHART
class RadarChartWidget extends StatelessWidget {
  const RadarChartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return RadarChart(
      RadarChartData(
        radarShape: RadarShape.polygon,
        tickCount:3,
        dataSets: [
          RadarDataSet(
            fillColor: Colors.teal.withValues(alpha: 0.4),
            borderColor: Colors.teal,
            entryRadius: 3,dataEntries: [
              RadarEntry(value: 3),
              RadarEntry(value: 4),
              RadarEntry(value: 5),
              RadarEntry(value: 2),
              RadarEntry(value: 4),
            ]
          )
        ]
      )
    );
  }
}