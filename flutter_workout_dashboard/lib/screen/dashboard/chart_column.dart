import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../constants.dart';
import '../../models/chart_column_data.dart';

class ChartColumn extends StatefulWidget {
  const ChartColumn({super.key});

  @override
  State<ChartColumn> createState() => _ChartColumnState();
}

class _ChartColumnState extends State<ChartColumn> {
  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      plotAreaBackgroundColor: Colors.transparent,
      margin: EdgeInsets.all(0),
      borderWidth: 0,
      plotAreaBorderWidth: 0,
      primaryXAxis: CategoryAxis(
        labelStyle: TextStyle(color: Colors.white),
        plotOffset: 20,
        axisLine: AxisLine(width: 0),
        edgeLabelPlacement: EdgeLabelPlacement.shift,
        majorGridLines: MajorGridLines(width: 0),
        majorTickLines: MajorTickLines(width: 0),
      ),
      primaryYAxis: NumericAxis(
        majorGridLines: MajorGridLines(width: 1, color: bgColor),
        majorTickLines: MajorTickLines(width: 0),
        axisLine: AxisLine(width: 0),
        labelStyle: TextStyle(color: Colors.white),
        isVisible: true,
        minimum: 1000,
        maximum: 5000,
        interval: 1000,
      ),
      series: <CartesianSeries>[
        ColumnSeries<ChartColumnData, String>(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
          dataSource: chartData,
          width: 0.3,
          gradient: LinearGradient(
            colors: [Color(0xFF7EF94E), Color(0xFF526ADA)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          xValueMapper: (ChartColumnData data, _) => data.x,
          yValueMapper: (ChartColumnData data, _) => data.y,
        ),
        ColumnSeries<ChartColumnData, String>(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
          dataSource: chartData,
          width: 0.3,
          gradient: LinearGradient(
            colors: [Color(0xFF9B3AD8), Color(0xFF526ADA)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          xValueMapper: (ChartColumnData data, _) => data.x,
          yValueMapper: (ChartColumnData data, _) => data.y1,
        ),
      ],
    );
  }
}

final List<ChartColumnData> chartData = <ChartColumnData>[
  ChartColumnData("Aug", 4700, 3000),
  ChartColumnData("Sep", 3000, 5000),
  ChartColumnData("Oct", 3500, 2000),
];
