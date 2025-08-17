import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChartPage extends StatefulWidget {
  const ChartPage({super.key});

  @override
  State<ChartPage> createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> {
  late TransformationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TransformationController();
    _loadTransform();
    _controller.addListener(_saveTransform);
  }

  @override
  void dispose() {
    _controller.removeListener(_saveTransform);
    _controller.dispose();
    super.dispose();
  }

  Future<void> _saveTransform() async {
    final prefs = await SharedPreferences.getInstance();
    final values = _controller.value.storage;
    final list = values.toList();
    await prefs.setStringList(
      'chart_transform',
      list.map((e) => e.toString()).toList(),
    );
  }

  Future<void> _loadTransform() async {
    final prefs = await SharedPreferences.getInstance();
    final stored = prefs.getStringList('chart_transform');
    if (stored != null && stored.length == 16) {
      final doubles = stored.map((e) => double.parse(e)).toList();
      setState(() {
        _controller.value = Matrix4.fromList(doubles);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Zoomable Chart')),
      body: InteractiveViewer(
        transformationController: _controller,
        boundaryMargin: const EdgeInsets.all(100),
        minScale: 0.5,
        maxScale: 5,
        child: SizedBox(
          width: 1000, // supaya bisa discroll horizontal
          child: BarChart(
            BarChartData(
              titlesData: FlTitlesData(
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: true),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      final months = [
                        'Jan',
                        'Feb',
                        'Mar',
                        'Apr',
                        'May',
                        'Jun',
                        'Jul',
                        'Aug',
                        'Sep',
                        'Oct',
                        'Nov',
                        'Dec',
                      ];
                      return Text(months[value.toInt() % 12]);
                    },
                  ),
                ),
              ),
              barGroups: List.generate(12, (i) {
                return BarChartGroupData(
                  x: i,
                  barRods: [
                    BarChartRodData(toY: (i + 1) * 2.0, color: Colors.blue),
                  ],
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
