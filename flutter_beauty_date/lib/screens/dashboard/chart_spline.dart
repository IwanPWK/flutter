//27:06

import 'package:flutter/material.dart';
import 'package:flutter_beauty_date/constants.dart';
import 'package:flutter_beauty_date/models/chart_spline_data.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartSpline extends StatelessWidget {
  const ChartSpline({super.key});

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      onDataLabelRender: (DataLabelRenderArgs args) {
        if (args.pointIndex == 1) {
          args.text = "\$2.500,00";
          args.textStyle = TextStyle(
            fontSize: 14,
            color: Colors.white,
            fontWeight: FontWeight.w400,
          );
          args.offset = const Offset(0, 35);
        }
        if (args.pointIndex != 1) {
          args.text = '';
        }
      },
      onMarkerRender: (MarkerRenderArgs args) {
        if (!(args.pointIndex == 1)) {
          args.markerHeight = 0;
          args.markerWidth = 0;
        }
      },
      plotAreaBackgroundColor: Colors.transparent,
      margin: EdgeInsets.all(0),
      borderColor: Colors.transparent,
      borderWidth: 0,
      primaryXAxis: CategoryAxis(
        axisLine: AxisLine(width: 0),
        labelPlacement: LabelPlacement.onTicks,
        edgeLabelPlacement: EdgeLabelPlacement.shift,
        majorGridLines: MajorGridLines(width: 0),
        majorTickLines: MajorTickLines(width: 0),
        labelStyle: TextStyle(fontFamily: 'Roboto', fontSize: 14),
      ),
      primaryYAxis: NumericAxis(
        majorGridLines: MajorGridLines(width: 1, color: bgColor),
        majorTickLines: MajorTickLines(width: 0),
        axisLine: AxisLine(width: 0),
        minimum: 1000,
        maximum: 3000,
        interval: 500,
      ),
      series: <CartesianSeries>[
        SplineSeries<ChartSplineData, String>(
          dataLabelSettings: DataLabelSettings(
            color: primaryColor,
            borderColor: secondaryColor,
            borderWidth: 2,
            useSeriesColor: true,
            isVisible: true,
            labelAlignment: ChartDataLabelAlignment.top,
          ),
          color: secondaryColor2,
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
              secondaryColor2.withAlpha(150),
              secondaryColor2.withAlpha(10),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        SplineSeries<ChartSplineData, String>(
          markerSettings: MarkerSettings(
            isVisible: true,
            height: 10,
            width: 10,
          ),
          color: secondaryColor,
          width: 4,
          dataSource: chartData2,
          xValueMapper: (ChartSplineData data, _) => data.day,
          yValueMapper: (ChartSplineData data, _) => data.amount,
        ),
        SplineAreaSeries<ChartSplineData, String>(
          dataSource: chartData2,
          xValueMapper: (ChartSplineData data, _) => data.day,
          yValueMapper: (ChartSplineData data, _) => data.amount,
          gradient: LinearGradient(
            colors: [
              secondaryColor.withAlpha(150),
              secondaryColor.withAlpha(10),
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
  ChartSplineData('Mo', 1000),
  ChartSplineData('Tu', 2000),
  ChartSplineData('We', 1500),
  ChartSplineData('Th', 2800),
  ChartSplineData('Fr', 1500),
  ChartSplineData('Sa', 2500),
  ChartSplineData('Su', 1500),
];

final List<ChartSplineData> chartData2 = <ChartSplineData>[
  ChartSplineData('Mo', 1500),
  ChartSplineData('Tu', 2500),
  ChartSplineData('We', 2000),
  ChartSplineData('Th', 1500),
  ChartSplineData('Fr', 2800),
  ChartSplineData('Sa', 2500),
  ChartSplineData('Su', 2000),
];
