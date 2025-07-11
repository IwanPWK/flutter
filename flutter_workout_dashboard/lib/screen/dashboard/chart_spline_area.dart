import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../constants.dart';
import '../../models/chart_spline_data.dart';

class ChartSplineArea extends StatelessWidget {
  const ChartSplineArea({super.key});

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      onDataLabelRender: (DataLabelRenderArgs args) {
        if (args.pointIndex == 4) {
          args.text = "7Km";
          args.textStyle = TextStyle(
            fontSize: 16,
            color: Colors.black,
            fontWeight: FontWeight.w900,
          );
        } else {
          args.text = '';
        }
      },
      onMarkerRender: (MarkerRenderArgs args) {
        if (!(args.pointIndex == 4)) {
          args.markerHeight = 0;
          args.markerWidth = 0;
        }
      },
      plotAreaBackgroundColor: Colors.transparent,
      margin: EdgeInsets.all(0),
      borderWidth: 0,
      plotAreaBorderWidth: 0,
      primaryXAxis: CategoryAxis(
        axisLine: AxisLine(width: 0),
        labelPlacement: LabelPlacement.onTicks,
        labelStyle: TextStyle(color: Colors.white),
        edgeLabelPlacement: EdgeLabelPlacement.shift,
        majorGridLines: MajorGridLines(width: 0),
        majorTickLines: MajorTickLines(width: 0),
      ),
      primaryYAxis: NumericAxis(
        majorGridLines: MajorGridLines(width: 0),
        majorTickLines: MajorTickLines(width: 0),
        axisLine: AxisLine(width: 0),
        labelStyle: TextStyle(color: Colors.white),

        minimum: 2,
        maximum: 10,
        interval: 2,
      ),
      series: <CartesianSeries<ChartSplineData, String>>[
        SplineSeries(
          color: Color(0xFF9644FF),
          width: 2,
          dataSource: chartData,
          xValueMapper: (ChartSplineData data, _) => data.month,
          yValueMapper: (ChartSplineData data, _) => data.amount,
        ),
        SplineAreaSeries(
          dataSource: chartData,
          xValueMapper: (ChartSplineData data, _) => data.month,
          yValueMapper: (ChartSplineData data, _) => data.amount,
          gradient: LinearGradient(
            colors: [Color(0xFF342C9C), Color(0xFF342C9C).withAlpha(23)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        SplineSeries(
          color: Color(0xFF54AFBC),
          width: 2,

          markerSettings: MarkerSettings(
            isVisible: true,
            color: primaryColor,
            borderColor: Color(0xFF54AFBC),
            borderWidth: 4,
            height: 20,
            width: 20,
          ),
          dataLabelSettings: DataLabelSettings(
            useSeriesColor: true,
            isVisible: true,
            labelAlignment: ChartDataLabelAlignment.top,
          ),
          dataSource: chartData2,
          xValueMapper: (ChartSplineData data, _) => data.month,
          yValueMapper: (ChartSplineData data, _) => data.amount,
        ),
        SplineAreaSeries(
          dataSource: chartData2,
          xValueMapper: (ChartSplineData data, _) => data.month,
          yValueMapper: (ChartSplineData data, _) => data.amount,
          gradient: LinearGradient(
            colors: [Color(0xFF18506A), Color(0xFF28506A).withAlpha(23)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
      ],
    );
  }
}

final List<ChartSplineData> chartData = <ChartSplineData>[
  ChartSplineData("Mo", 2),
  ChartSplineData("Tu", 4),
  ChartSplineData("Wed", 3),
  ChartSplineData("Thur", 8),
  ChartSplineData("Fri", 5),
  ChartSplineData("Sat", 7),
  ChartSplineData("Sun", 4),
];
final List<ChartSplineData> chartData2 = <ChartSplineData>[
  ChartSplineData("Mo", 4),
  ChartSplineData("Tu", 5),
  ChartSplineData("Wed", 9),
  ChartSplineData("Thur", 4),
  ChartSplineData("Fri", 7),
  ChartSplineData("Sat", 3),
  ChartSplineData("Sun", 7),
];
