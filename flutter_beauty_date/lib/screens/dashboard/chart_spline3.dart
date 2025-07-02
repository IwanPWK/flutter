import 'package:flutter/material.dart';
import 'package:flutter_beauty_date/constants.dart';
import 'package:flutter_beauty_date/models/chart_spline_data.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartSpline3 extends StatelessWidget {
  const ChartSpline3({super.key});

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      plotAreaBackgroundColor: Colors.transparent,
      margin: EdgeInsets.all(0),
      borderColor: Colors.transparent,
      borderWidth: 0,
      plotAreaBorderWidth: 0,
      primaryXAxis: CategoryAxis(isVisible: false),
      primaryYAxis: NumericAxis(isVisible: false),
      series: <CartesianSeries>[
        SplineSeries<ChartSplineData, String>(
          color: secondaryColor,
          width: 4,
          dataSource: chartData,
          xValueMapper: (ChartSplineData data, _) => data.day,
          yValueMapper: (ChartSplineData data, _) => data.amount,
        ),
        SplineAreaSeries<ChartSplineData, String>(
          dataSource: chartData,
          xValueMapper: (ChartSplineData data, _) => data.day,
          yValueMapper: (ChartSplineData data, _) => data.amount,
          gradient: LinearGradient(
            colors: [
              secondaryColor.withAlpha(150),
              secondaryColor2.withAlpha(23),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
      ],
    );
  }
}

final List<ChartSplineData> chartData = <ChartSplineData>[
  ChartSplineData('Mo', 2),
  ChartSplineData('Tu', 8),
  ChartSplineData('We', 5),
  ChartSplineData('Th', 7),
  ChartSplineData('Fr', 5),
];
