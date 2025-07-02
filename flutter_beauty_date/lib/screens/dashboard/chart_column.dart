import 'package:flutter/material.dart';
import 'package:flutter_beauty_date/constants.dart';
import 'package:flutter_beauty_date/models/chart_column_data.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartColumn extends StatelessWidget {
  const ChartColumn({super.key});

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      plotAreaBackgroundColor: Colors.transparent,
      margin: EdgeInsets.all(0),
      borderColor: Colors.transparent,
      borderWidth: 0,
      plotAreaBorderWidth: 0,
      primaryXAxis: CategoryAxis(
        axisLine: AxisLine(width: 0),
        edgeLabelPlacement: EdgeLabelPlacement.shift,
        majorGridLines: MajorGridLines(width: 0),
        majorTickLines: MajorTickLines(width: 0),
        labelStyle: TextStyle(
          color: Colors.white,
          fontFamily: "Roboto",
          fontSize: 10,
          fontWeight: FontWeight.w500,
        ),
      ),
      primaryYAxis: NumericAxis(
        axisLine: AxisLine(width: 0),
        majorGridLines: MajorGridLines(width: 1, color: bgColor),
        majorTickLines: MajorTickLines(width: 0),
        isVisible: true,
        minimum: 10,
        maximum: 50,
        interval: 10,
      ),
      series: <CartesianSeries>[
        ColumnSeries<ChartColumnData, String>(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
          dataSource: chartData,
          width: 0.4,
          color: secondaryColor2,
          borderColor: primaryColor,
          borderWidth: 2,
          xValueMapper: (ChartColumnData data, _) => data.x,
          yValueMapper: (ChartColumnData data, _) => data.y,
        ),
        ColumnSeries<ChartColumnData, String>(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
          dataSource: chartData,
          width: 0.4,
          color: secondaryColor,
          borderColor: primaryColor,
          borderWidth: 2,
          xValueMapper: (ChartColumnData data, _) => data.x,
          yValueMapper: (ChartColumnData data, _) => data.y1,
        ),
      ],
    );
  }
}

final List<ChartColumnData> chartData = <ChartColumnData>[
  ChartColumnData('Mo', 20, 35),
  ChartColumnData('Tu', 40, 32),
  ChartColumnData('We', 30, 34),
  ChartColumnData('Th', 42, 50),
  ChartColumnData('Fr', 32, 50),
  ChartColumnData('Sa', 42, 45),
  ChartColumnData('Su', 35, 50),
];
